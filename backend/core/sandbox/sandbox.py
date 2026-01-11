from dotenv import load_dotenv
from core.utils.logger import logger
from core.utils.config import config
import asyncio

load_dotenv()

# Daytona est optionnel - ne l'importons et initialisons que si configuré
daytona = None
daytona_available = False

try:
    if config.DAYTONA_API_KEY and config.DAYTONA_SERVER_URL:
        from daytona_sdk import AsyncDaytona, DaytonaConfig, CreateSandboxFromSnapshotParams, AsyncSandbox, SessionExecuteRequest, Resources, SandboxState

        daytona_config = DaytonaConfig(
            api_key=config.DAYTONA_API_KEY,
            api_url=config.DAYTONA_SERVER_URL,
            target=config.DAYTONA_TARGET,
        )

        daytona = AsyncDaytona(daytona_config)
        daytona_available = True
        logger.info("Daytona sandbox configured successfully")
    else:
        logger.info("Daytona not configured - sandbox features will be disabled")

except ImportError:
    logger.warning("Daytona SDK not available - sandbox features will be disabled")
except Exception as e:
    logger.error(f"Failed to initialize Daytona: {e}")
    logger.info("Sandbox features will be disabled")

async def get_or_start_sandbox(sandbox_id: str) -> AsyncSandbox:
    """Retrieve a sandbox by ID, check its state, and start it if needed."""

    if not daytona_available or daytona is None:
        raise RuntimeError("Daytona sandbox is not configured or available")

    logger.info(f"Getting or starting sandbox with ID: {sandbox_id}")

    try:
        sandbox = await daytona.get(sandbox_id)
    except Exception as e:
        logger.error(f"Failed to get sandbox {sandbox_id}: {e}")
        raise
        
        # Check if sandbox needs to be started
        if sandbox.state in [SandboxState.ARCHIVED, SandboxState.STOPPED, SandboxState.ARCHIVING]:
            logger.info(f"Sandbox is in {sandbox.state} state. Starting...")
            try:
                await daytona.start(sandbox)
                
                # Wait for sandbox to reach STARTED state
                for _ in range(30):
                    await asyncio.sleep(1)
                    sandbox = await daytona.get(sandbox_id)
                    if sandbox.state == SandboxState.STARTED:
                        break
                
                # Start supervisord in a session when restarting
                await start_supervisord_session(sandbox)
            except Exception as e:
                logger.error(f"Error starting sandbox: {e}")
                raise e
        
        logger.info(f"Sandbox {sandbox_id} is ready")
        return sandbox
        
    except Exception as e:
        logger.error(f"Error retrieving or starting sandbox: {str(e)}")
        raise e

async def start_supervisord_session(sandbox: AsyncSandbox):
    """Start supervisord in a session."""
    session_id = "supervisord-session"
    try:
        await sandbox.process.create_session(session_id)
        await sandbox.process.execute_session_command(session_id, SessionExecuteRequest(
            command="exec /usr/bin/supervisord -n -c /etc/supervisor/conf.d/supervisord.conf",
            var_async=True
        ))
        logger.info("Supervisord started successfully")
    except Exception as e:
        # Don't fail if supervisord already running
        logger.warning(f"Could not start supervisord: {str(e)}")

async def create_sandbox(password: str, project_id: str = None) -> AsyncSandbox:
    """Create a new sandbox with all required services configured and running."""

    if not daytona_available or daytona is None:
        raise RuntimeError("Daytona sandbox is not configured or available")

    logger.info("Creating new Daytona sandbox environment")
    # logger.debug("Configuring sandbox with snapshot and environment variables")
    
    labels = None
    if project_id:
        # logger.debug(f"Using sandbox_id as label: {project_id}")
        labels = {'id': project_id}
        
    params = CreateSandboxFromSnapshotParams(
        snapshot=Configuration.SANDBOX_SNAPSHOT_NAME,
        public=True,
        labels=labels,
        env_vars={
            "CHROME_PERSISTENT_SESSION": "true",
            "RESOLUTION": "1048x768x24",
            "RESOLUTION_WIDTH": "1048",
            "RESOLUTION_HEIGHT": "768",
            "VNC_PASSWORD": password,
            "ANONYMIZED_TELEMETRY": "false",
            "CHROME_PATH": "",
            "CHROME_USER_DATA": "",
            "CHROME_DEBUGGING_PORT": "9222",
            "CHROME_DEBUGGING_HOST": "localhost",
            "CHROME_CDP": ""
        },
        # resources=Resources(
        #     cpu=2,
        #     memory=4,
        #     disk=5,
        # ),
        auto_stop_interval=15,
        auto_archive_interval=30,
    )
    
    # Create the sandbox
    sandbox = await daytona.create(params)
    logger.info(f"Sandbox created with ID: {sandbox.id}")
    
    # Start supervisord in a session for new sandbox
    await start_supervisord_session(sandbox)
    
    logger.info(f"Sandbox environment successfully initialized")
    return sandbox

async def delete_sandbox(sandbox_id: str) -> bool:
    """Delete a sandbox by its ID."""

    if not daytona_available or daytona is None:
        logger.warning("Daytona not available - cannot delete sandbox")
        return False

    logger.info(f"Deleting sandbox with ID: {sandbox_id}")

    try:
        # Get the sandbox
        sandbox = await daytona.get(sandbox_id)
        
        # Delete the sandbox
        await daytona.delete(sandbox)
        
        logger.info(f"Successfully deleted sandbox {sandbox_id}")
        return True
    except Exception as e:
        logger.error(f"Error deleting sandbox {sandbox_id}: {str(e)}")
        raise e
