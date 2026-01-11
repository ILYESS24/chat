# 🚀 DÉPLOIEMENT COMPLET KORTIX SUR RENDER

## ⚡ VERSION ULTRA-SIMPLE (RECOMMANDÉ)

### UNE SEULE COMMANDE :
```powershell
# 1. Ouvrez PowerShell en tant qu'Administrateur
# 2. Allez dans le dossier du projet
cd "C:\Users\[VOTRE_NOM]\Downloads\suna-main (1)\suna-main"

# 3. Lancez le script magique
.\DEPLOY-TOUT.ps1
```

**C'EST TOUT !** Le script fait absolument tout automatiquement.

---

## 📋 CE QUE FAIT LE SCRIPT

| Étape | Action | Temps |
|-------|--------|-------|
| 1 | Installation automatique de Python | 2-3 min |
| 2 | Configuration des clés API (vous) | 3 min |
| 3 | Installation des dépendances | 1 min |
| 4 | Test de configuration | 30 sec |
| 5 | Déploiement sur Render | 10-15 min |
| **Total** | | **16-22 minutes** |

---

## 🎯 RÉSULTAT FINAL

Après succès, vous aurez :

### 🌐 Services déployés :
- **kortix-frontend** : Application Next.js
- **kortix-backend** : API FastAPI
- **kortix-db** : Base de données PostgreSQL

### 🔗 URLs d'accès :
- Application : `https://kortix-frontend.onrender.com`
- API : `https://kortix-backend.onrender.com`

---

## 🔧 PRÉ-REQUIS

### Matériel :
- ✅ Windows 10/11
- ✅ Connexion internet
- ✅ Droits administrateur (pour installer Python)

### Logiciel :
- ✅ PowerShell (installé par défaut)
- ⚠️ Python (installé automatiquement par le script)

---

## 🚨 DÉPANNAGE EXPRESS

### "Execution Policy"
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### "Python n'est pas installé"
Le script l'installe automatiquement. Si ça échoue :
- Téléchargez manuellement : https://python.org/downloads
- Cochez "Add to PATH"

### "Clés API manquantes"
- **Render API** : https://dashboard.render.com/account/api-keys
- **Supabase** : Dashboard Supabase → Settings → API
- **OpenAI** : https://platform.openai.com/api-keys
- **Stripe** : https://dashboard.stripe.com/apikeys

---

## 📞 SUPPORT

### Vérification rapide :
```powershell
.\VERIFICATION-RAPIDE.ps1
```

### Logs détaillés :
Consultez la console PowerShell pendant l'exécution.

### Problèmes courants :
1. **Réseau lent** → Attendez plus longtemps
2. **Clé API invalide** → Vérifiez dans les dashboards
3. **Port occupé** → Fermez autres programmes

---

## 🎊 APRÈS DÉPLOIEMENT

### Vérifications :
1. Allez sur https://dashboard.render.com
2. Vérifiez que les 3 services sont "live"
3. Testez les URLs dans votre navigateur

### Mises à jour :
```powershell
# Pour déployer les changements futurs
python auto-deploy-render.py
```

---

## 📚 FICHIERS DE RÉFÉRENCE

- `GUIDE-VISUEL.md` - Guide détaillé avec captures d'écran
- `DEPLOYMENT-README.md` - Documentation complète
- `INSTALLATION-RAPIDE.md` - Installation pas à pas

---

## 🎯 CONCLUSION

**Lancez `.\DEPLOY-TOUT.ps1` et laissez le script travailler !**

Le déploiement complet prend 15-20 minutes. À la fin, votre application Kortix sera en ligne et accessible partout. 🚀

---

*Dernière mise à jour : $(Get-Date -Format "yyyy-MM-dd HH:mm")*
