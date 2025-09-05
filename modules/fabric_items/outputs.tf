output "items" {
  description = "Itens criados no workspace (lakehouses, warehouses, pipelines, notebooks, eventstreams, kql_databases)"
  value = {
    lakehouses = {
      for k, v in fabric_lakehouse.this :
      k => {
        id           = v.id
        display_name = v.display_name
      }
    }
    warehouses = {
      for k, v in fabric_warehouse.this :
      k => {
        id           = v.id
        display_name = v.display_name
      }
    }
    pipelines = {
      for k, v in fabric_data_pipeline.this :
      k => {
        id           = v.id
        display_name = v.display_name
      }
    }
    notebooks = {
      for k, v in fabric_notebook.this :
      k => {
        id           = v.id
        display_name = v.display_name
      }
    }
    eventstreams = {
      for k, v in fabric_eventstream.this :
      k => {
        id           = v.id
        display_name = v.display_name
      }
    }
    kql_databases = {
      for k, v in fabric_kql_database.this :
      k => {
        id           = v.id
        display_name = v.display_name
      }
    }
  }
}
