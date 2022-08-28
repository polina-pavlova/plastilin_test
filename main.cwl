class: Workflow
cwlVersion: v1.0

requirements:
 - class: ScatterFeatureRequirement
 - class: SubworkflowFeatureRequirement
 - class: InlineJavascriptRequirement
 - class: MultipleInputFeatureRequirement
 
 
inputs:
  fastqForward: File
  fastqReverse: File
  referenceGenome: File
  minlen: int
  slidingwindow: string
  leading: int
  trailing: int
 
      
steps:      
  - id: qc_fwd
    in:
      reads_file:
        - fastqForward
    out:
      - zipped_file
      - html_file
      - summary_file
    run: ./tools/fastqc.cwl
    
  - id: qc_rev
    in:
      reads_file:
        - fastqReverse
    out:
      - zipped_file
      - html_file
      - summary_file
    run: ./tools/fastqc.cwl
      
  - id: trimming
    in:
      forward:
        - fastqForward
      reverse:
        - fastqReverse
      leading:
        - leading
      trailing: 
        - trailing
      slidingwindow:
        - slidingwindow
      minlen: 
        - minlen
    out:
      - forwardPaired
      - reversePaired
      - forwardUnpaired
      - reverseUnpaired
      - log
    run: ./tools/trimmomatic.cwl
    
  - id: genomeIndexing
    in: 
      fa: 
        - referenceGenome
    out: 
      - amb
      - ann
      - bwt
      - pac
      - sa
    run: ./tools/bwa_index.cwl
    
      
  - id: bwaAlignment
    in:
      reference:
        - referenceGenome
      reference_amb:
        - genomeIndexing/amb
      reference_ann:
        - genomeIndexing/ann
      reference_bwt:
        - genomeIndexing/bwt
      reference_pac:
        - genomeIndexing/pac
      reference_sa:
        - genomeIndexing/sa
      fq1:
        - trimming/forwardPaired
      fq2:
        - trimming/reversePaired
    out:
      - sam
    run: ./tools/bwa_mem.cwl
    
outputs:
  qc_f:
    type: File
    outputSource: qc_fwd/html_file
  qc_r:
    type: File
    outputSource: qc_rev/html_file
  bwaMem:
    type: File
    outputSource: bwaAlignment/sam
  FP:
    type: File
    outputSource: trimming/forwardPaired
  RP:
    type: File
    outputSource: trimming/reversePaired
  FU:
    type: File
    outputSource: trimming/forwardUnpaired
  RU:
    type: File
    outputSource: trimming/reverseUnpaired
