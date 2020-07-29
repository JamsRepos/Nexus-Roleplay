resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

files {
    'vlayouts/vehiclelayouts-*.meta',
    'vmetas/vehicles-*.meta',
    'carvs/carvariations-*.meta',
    'carcols/carcols-*.meta',
    'handling/handling-*.meta',
}

data_file 'HANDLING_FILE' 'handling/handling-*.meta'
data_file 'VEHICLE_LAYOUTS_FILE' 'vlayouts/vehiclelayouts-*.meta'
data_file 'VEHICLE_METADATA_FILE' 'vmetas/vehicles-*.meta'
data_file 'CARCOLS_FILE' 'carcols/carcols-*.meta'
data_file 'VEHICLE_VARIATION_FILE' 'carvs/carvariations-*.meta'

client_script {
    'vehicle_names.lua'
}