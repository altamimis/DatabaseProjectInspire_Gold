CREATE EXTERNAL DATA SOURCE [gold]
    WITH (
    LOCATION = N'https://mcainspiredev01syn.dfs.core.windows.net/synapse/synapse/workspaces/mca-inspiredev-01-syn/warehouse/combined_gold.db',
    CREDENTIAL = [WorkspaceIdentity]
    );


GO

