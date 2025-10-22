.
├── agents
├── bootstrap_hydration_system
│   ├── vector_db
│   │   └── index.faiss
│   └── vector_init.py
├── bootstrap_memory_gateway
│   ├── api
│   │   ├── main.py
│   │   └── run_local.sh
│   ├── cloudrun_deploy.sh
│   ├── HYDRATION_MANIFEST.json
│   └── schemas
│       └── firestore_schema.json
├── bootstrap_secret_sync
│   ├── backups
│   │   ├── agent-api-key.txt
│   │   ├── AGENT_NAME.txt
│   │   ├── agent-whitelist.txt
│   │   ├── API_KEY_SECRET.txt
│   │   ├── app-env.txt
│   │   ├── backend-api-key.txt
│   │   ├── captcha_cfg.txt
│   │   ├── chain-rpc-url.txt
│   │   ├── codex-api-key.txt
│   │   ├── CODEX_API_KEY.txt
│   │   ├── CODEX_GCP_API_KEY.txt
│   │   ├── CODEX_GOOGLE_KEY.txt
│   │   ├── CODEX_ROOT_ACCESS_CODE.txt
│   │   ├── CODEX_VERCEL_TOKEN.txt
│   │   ├── coinbase.txt
│   │   ├── dashboard-api-key.txt
│   │   ├── ETHERSCAN_API_KEY_01.txt
│   │   ├── ETHERSCAN_API_KEY_02.txt
│   │   ├── ETHERSCAN_API_KEY_03.txt
│   │   ├── etherscan.txt
│   │   ├── faucet_api_keys.txt
│   │   ├── faucet_endpoints.txt
│   │   ├── GCP_SA_KEY.txt
│   │   ├── GCP_SERVICE_KEY.txt
│   │   ├── gcs-bucket-artifacts.txt
│   │   ├── GETBLOCK_API_KEY_1.txt
│   │   ├── GETBLOCK_API_KEY_2.txt
│   │   ├── getblock.txt
│   │   ├── GITHUB_PAT.txt
│   │   ├── github-token.txt
│   │   ├── GITHUB_TOKEN.txt
│   │   ├── GOOGLE_INFINITY_X_ONE_SWARM_SYSTEM_JSON_KEY.txt
│   │   ├── groq-api-key.txt
│   │   ├── GROQ_API_KEY.txt
│   │   ├── harvester-api-key.txt
│   │   ├── harvester-auth.txt
│   │   ├── hmac-secret.txt
│   │   ├── infinity-env.txt
│   │   ├── INFINITY_X_GITHUB_REPO.txt
│   │   ├── INFINITY_X_ONE_SWARM_SYSTEM_GITHUB_REPO.txt
│   │   ├── INFURA_RPC_API_KEY.txt
│   │   ├── infura.txt
│   │   ├── ipc-socket-path.txt
│   │   ├── JWT_AUDIENCE.txt
│   │   ├── JWT_ISSUER.txt
│   │   ├── LANGCHAIN_API_KEY.txt
│   │   ├── llm-env.txt
│   │   ├── memory-gateway-url.txt
│   │   ├── METAMASK_DEV_API_KEY.txt
│   │   ├── METAMASK_GAS_API.txt
│   │   ├── metamask.txt
│   │   ├── MORALIS_API_KEY.txt
│   │   ├── moralis.txt
│   │   ├── OPENAI_API_KEY.txt
│   │   ├── OPEN_API_KEY.txt
│   │   ├── oracle-pk.txt
│   │   ├── orchestrator-api-key.txt
│   │   ├── PHANTOM_BITCOIN_WALLET_KEY.txt
│   │   ├── PHANTOM_ETHEREUM_WALLET_KEY.txt
│   │   ├── PHANTOM_SOLONA_WALLET.txt
│   │   ├── PHANTOM_SWARM_ETHEREUM_WALLET_KET_02.txt
│   │   ├── PHANTOM_SWARM_ETHEREUM_WALLET_KEY_02.txt
│   │   ├── PHANTOM_SWARM_ETHEREUM_WALLET_KEY.txt
│   │   ├── PHANTOM_SWARM_SOLANA_WALLET_KEY_02.txt
│   │   ├── PHANTOM_SWARM_SOLANA_WALLET_KEY.txt
│   │   ├── proxy_pool.txt
│   │   ├── pubsub-topic-harvest.txt
│   │   ├── QUICKNODE_KEY_1.txt
│   │   ├── QUICKNODE_KEY_2.txt
│   │   ├── QUICKNODE_KEY_3.txt
│   │   ├── quicknode.txt
│   │   ├── root-access-code.txt
│   │   ├── sql-connection-string.txt
│   │   ├── SQL_PASS.txt
│   │   ├── SUPABASE_ANON_KEY.txt
│   │   ├── SUPABASE_SERVICE_KEY.txt
│   │   ├── SUPABASE_SERVICE_ROLE_KEY.txt
│   │   ├── SUPABASE_URL.txt
│   │   ├── VERCEL_AUTOMATION_BYPASS_SECRET.txt
│   │   ├── VERCEL_PROJECT_ID.txt
│   │   ├── vercel-token.txt
│   │   ├── VERCEL_TOKEN.txt
│   │   ├── VERCEL_USER_ID.txt
│   │   ├── wallet-addresses.txt
│   │   ├── wallets-list.txt
│   │   └── wallets-verified.txt
│   ├── logs
│   │   ├── sync_20251022-021732.log
│   │   ├── sync_20251022-022458.log
│   │   └── sync_20251022-023009.log
│   ├── SCHEMA.md
│   └── SECRET_SYNC_STATUS.md
├── ci
│   └── github-actions
│       └── deploy.yml
├── docs
│   └── SYSTEM_STATUS.md
├── HUMAN_DOC.md
├── logs
│   ├── auto_ops_2025-10-22.log
│   └── tree_update.log
├── MACHINE_DOC.md
├── main
├── README.md
├── REPO_TREE.md
├── schema
│   └── bootstrap
├── scripts
│   ├── autoheal.sh
│   ├── auto_tree.sh
│   ├── bootstrap_all_workflows.sh
│   ├── bootstrap_autonomy.sh
│   ├── bootstrap_env.sh
│   ├── bootstrap_hydration_vector.sh
│   ├── bootstrap_memory_gateway.sh
│   ├── bootstrap_secret_sync.sh
│   ├── cloud_autoheal.sh
│   ├── cloud_autoheal.sh.save
│   ├── code_autofix.py
│   ├── local_sync.sh
│   ├── memory_sync.sh
│   ├── production_auto_ops.sh
│   ├── repo_agent.sh
│   ├── repo_autoheal.sh
│   ├── schema_sync.sh
│   ├── sync_all_secrets.sh
│   ├── sync_secrets.sh
│   └── treemd.sh
├── secrets
├── TREE.md
└── vercel

19 directories, 128 files
