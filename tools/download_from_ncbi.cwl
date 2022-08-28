class: CommandLineTool
cwlVersion: v1.0

requirements:
  InitialWorkDirRequirement:
    listing:
      - entryname: .ncbi/user-settings.mkfg
        entry: |-
          /LIBS/GUID = "0df5ebb2-dcc0-4a83-b71f-b5d31e5bda3e"
          /libs/cloud/report_instance_identity = "true"
          	
baseCommand: python
inputs:
  script:
    type: File
    inputBinding: {position: 1}
    default:
      class: File
      location: download_data_from_ncbi.py
outputs:
  genome:
    type: File
    outputBinding:
      glob: "*.fna.gz"
  reads:
    type: Directory?
    outputBinding:
      glob: reads/
      
