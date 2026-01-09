import React, { useState } from "react";
import { HomeView } from "./HomeView";
import { ActiveChatView } from "./ActiveChatView";

export const ChatInterface = () => {
  const [hasStartedChat, setHasStartedChat] = useState(false);

  if (hasStartedChat) {
    return <ActiveChatView />;
  }

  return <HomeView onStartChat={() => setHasStartedChat(true)} />;
};
