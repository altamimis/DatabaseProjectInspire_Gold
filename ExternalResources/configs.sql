CREATE EXTERNAL DATA SOURCE [configs]
    WITH (
    LOCATION = N'https://mcainspiredev01syn.dfs.core.windows.net/synapse/synapse/workspaces/mca-inspiredev-01-syn/warehouse/configs.db',
    CREDENTIAL = [WorkspaceIdentity]
    );


GO

