class: CommandLineTool
cwlVersion: v1.0

requirements:
  - class: ResourceRequirement
    coresMin: 4
baseCommand: TrimmomaticPE

arguments:
  - position: 2
    prefix: '-baseout'
    valueFrom: 'trimmomatic.fastq.gz'
  - position: 3
    prefix: '-threads'
    valueFrom: '$(runtime.cores)'

inputs:
  forward:
    type: File
    inputBinding:
      position: 4
  reverse:
    type: File
    inputBinding:
      position: 5
  leading:
    type: int?
    inputBinding:
      position: 7
      prefix: 'LEADING:'
      separate: false
  trailing:
    type: int?
    inputBinding:
      position: 8
      prefix: 'TRAILING:'
      separate: false
  slidingwindow:
    type: string?
    inputBinding:
      position: 9
      prefix: 'SLIDINGWINDOW:'
      separate: false
  minlen:
    type: int?
    inputBinding:
      position: 10
      prefix: 'MINLEN:'
      separate: false
      
outputs:
  forwardPaired:
    type: File
    format: 'fastq.gz'
    outputBinding:
      glob: "trimmomatic_1P.fastq.gz"
  reversePaired:
    type: File
    format: 'fastq.gz'
    outputBinding:
      glob: "trimmomatic_2P.fastq.gz"
  forwardUnpaired:
    type: File
    format: 'fastq.gz'
    outputBinding:
      glob: "trimmomatic_1U.fastq.gz"
  reverseUnpaired:
    type: File
    format: 'fastq.gz'
    outputBinding:
      glob: "trimmomatic_2U.fastq.gz"
  log:
    type: stderr

stderr: trimmomatic.log

