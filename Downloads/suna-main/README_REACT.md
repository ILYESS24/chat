# 🎨 Kortix AI React Interface

Interface React moderne et complète pour Kortix AI avec toutes les fonctionnalités avancées.

## 🚀 Fonctionnalités Implémentées

### ✅ Interface Principale
- **Sidebar moderne** avec navigation par onglets
- **Interface de chat** avec deux vues (Home/Active)
- **Design sombre professionnel** cohérent
- **Responsive design** pour tous les appareils

### ✅ Panneaux Avancés
- **🔗 Intégrations** : Google Drive, Docs, Sheets, Slack, Notion, GitHub
- **📚 Library** : Outils IA organisés par catégories
- **⏰ Triggers** : Automatisation temporelle, événements, webhooks
- **🔧 MCP** : Serveurs Model Context Protocol
- **🤖 Agents** : Gestion d'agents IA personnalisés
- **⚡ Workflows** : Pipelines d'automatisation

### ✅ Composants UI
- **Boutons interactifs** avec états hover/active
- **Modales élégantes** avec animations fluides
- **Formulaires configurables** pour chaque outil
- **Feedback utilisateur** temps réel

### ✅ Outils Disponibles
- **Video, Canvas, Slides, Data, Docs, Research**
- **Templates éditables** avec sauvegarde locale
- **Prévisualisation temps réel**
- **Téléchargements simulés**

## 🛠️ Installation & Lancement

### 1. Installer les dépendances
```bash
npm install
```

### 2. Lancer le serveur de développement
```bash
npm run dev
# ou directement avec :
npx vite --host 0.0.0.0 --port 3000
```

### 3. Ouvrir dans le navigateur
```
http://localhost:3000
```

## 📁 Structure du Projet

```
src/
├── components/
│   ├── home.tsx                 # Page principale
│   ├── ui/
│   │   ├── button.tsx          # Composant Button
│   │   └── badge.tsx           # Composant Badge
│   └── kortix/
│       ├── Sidebar.tsx         # Barre latérale
│       ├── ChatInterface.tsx   # Interface de chat
│       ├── HomeView.tsx        # Vue d'accueil
│       └── ActiveChatView.tsx  # Vue de chat actif
├── lib/
│   └── utils.ts                # Fonctions utilitaires
├── App.tsx                     # Application principale
├── main.tsx                    # Point d'entrée React
└── index.css                   # Styles globaux
```

## 🎨 Technologies Utilisées

- **React 18** - Framework frontend
- **TypeScript** - Typage statique
- **Tailwind CSS** - Framework CSS
- **Lucide React** - Icônes
- **React Router** - Routing
- **Radix UI** - Composants accessibles
- **Vite** - Outil de build rapide

## 🎯 Fonctionnalités Clés

### Interface de Chat Moderne
- **Vue d'accueil** avec templates et outils
- **Vue de chat actif** avec historique
- **Panel latéral** avec outils Kortix Computer
- **Input intelligent** avec auto-resize

### Panneaux d'Outils Avancés
- **Modales fullscreen** avec backdrop blur
- **Navigation par catégories**
- **Actions simulées** avec feedback
- **Sauvegarde d'état** localStorage

### Design System Cohérent
- **Palette sombre** (#0D0D0D, #151515, #1A1A1A)
- **Typographie** (Inter, Space Grotesk)
- **Animations fluides** et transitions
- **États interactifs** complets

## 🔧 Scripts Disponibles

```bash
npm run dev      # Démarrer le serveur de développement
npm run build    # Build pour la production
npm run preview  # Prévisualiser le build
```

## 📱 Responsive Design

- **Desktop** : Interface complète avec tous les panneaux
- **Tablet** : Adaptation des grilles et modales
- **Mobile** : Interface optimisée avec navigation adaptée

## 🚀 Prochaines Étapes

1. **Connexions réelles** aux APIs backend
2. **Authentification** utilisateur
3. **Persistance** des données utilisateur
4. **Intégrations** tierces fonctionnelles
5. **Tests** et optimisation performance

---

**🎉 Interface React complète et moderne pour Kortix AI !**
