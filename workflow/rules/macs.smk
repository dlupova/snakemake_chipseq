rule callpeak:
    input:
        treatment=rules.bam_sort.output.bam    # required: treatment sample(s)
    output:
        xls="results/macs2/{sample}_{genome}_peaks.xls",
        narrowPeak="results/macs2/{sample}_{genome}_peaks.narrowPeak",
        bed="results/macs2/{sample}_{genome}_summits.bed"
    log:
        "logs/macs2/{sample}_{genome}_callpeak.log"
    params:
        "-f BAM -g hs"
    wrapper:
        "0.74.0/bio/macs2/callpeak"

rule callpeak_options:
    input:
        treatment=rules.bam_sort.output.bam  # required: treatment sample(s)
    output:
        # all output-files must share the same basename and only differ by it's extension
        # Usable extensions (and which tools they implicitly call) are listed here:
        #         https://snakemake-wrappers.readthedocs.io/en/stable/wrappers/macs2/callpeak.html.
        multiext("results/macs2/{sample}_{genome}",
                 "_peaks.xls",   ### required
                 ### optional output files
                 # these output extensions internally set the --bdg or -B option:
                 "_treat_pileup.bdg",
                 # these output extensions internally set the --broad option:
                 "_peaks.broadPeak",
                 "_peaks.gappedPeak"
                 )
    log:
        "logs/macs2/{sample}_{genome}_callpeak.log"
    params:
        "-f BAM -g hs"
    wrapper:
        "0.74.0/bio/macs2/callpeak"