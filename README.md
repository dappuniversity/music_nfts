# Lecteur de musique NFT

## Pile technologique et outils

- Solidity (Écriture de Smart Contract)
- Javascript (React et tests)
- [Ethers](https://docs.ethers.io/v5/) (Interaction avec la blockchain)
- [Hardhat](https://hardhat.org/) (Cadre de développement)
- [Ipfs](https://ipfs.io/) (stockage de métadonnées)
- [React routers](https://v5.reactrouter.com/) (Composants de navigation)

## Configuration requise pour l'installation initiale
- Installer [NodeJS](https://nodejs.org/en/), devrait fonctionner avec toute version de node inférieure à 16.5.0.
- Installation de [Hardhat](https://hardhat.org/)

## Configuration
### 1. Clonez/téléchargez le dépôt

### 2. Installer les dépendances :
```
$ cd music_nfts
$ npm install
```
### 3. Démarrer la blockchain locale de développement
```
$ cd music_nfts
$ npx hardhat node
```

### 4. Connecter les comptes blockchain de développement à Metamask

- Télécharger Metamask
- Cliquez sur importer une phrase 
- Copier et collez cette phrase : cash inquiry group security luggage famous duty taste mistake liquid fitness security
- Comme [password] mettez : @ndologie
- Cliquez sur [Ethereum Mainnet]
- Ensuite sur [Add network]
- Tout en bas cliquez sur [Add Network Manually]
- Entrez "Sueno Network" dans [Network Name]
- Entrez "http://127.0.0.1:8545" dans [New RPC URL]
- Entrez "31337" dans [Chain ID]
- Entrez "SNTK" dans [Currency Symbol]
- Et cliquez sur [Save]
- Choisissez le [Sueno Network] et ensuite cliquez sur [Account] et [Import Account]
- Copier la clé privée des adresses suivante :
  • Account #2
    Private Key: 0x5de4111afa1a4b94908f83103eb1f1706367c2e68ca870fc3fb9a804cdab365a
  • Account #3
    Private Key: 0x7c852118294e51e653712a81e05800f419141751be58f605c371e15141b007a6 
- Changez de compte et choisissez un des deux ci-dessus
- Vous disposez desormais de 10000 SNTK et vous pouvez donc acheter des NFT de l'albums.

### 5. Exécutez le script de déploiement pour migrer les contrats intelligents
`npm run deploy`

### 6. Exécutez les tests
`$ npx hardhat test`

### 7. Lancer le Frontend
`$ npm run start`

Licence
----
Ando Technologies

Traduit avec www.DeepL.com/Translator (version gratuite)