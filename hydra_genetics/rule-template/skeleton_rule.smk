# vim: syntax=python tabstop=4 expandtab
# coding: utf-8

__author__ = "{{ author }}"
__copyright__ = "Copyright {{ year }}, {{ author }}"
__email__ = "{{ email }}"
__license__ = "GPL-3"

rule {{ name }}:
    input:
        ...
    output:
        "{{ module_name }}/{{ name }}/{sample}_{unit}.output.txt"
    params:
        extra=config.get("{{ name }}", {}).get("extra", ""),
    log:
        "{{ module_name }}/{{ name }}/{sample}_{unit}.output.log"
    benchmark:
       repeat("{{ module_name }}/{{ name }}/{sample}_{unit}.output.benchmark.tsv", config.get("{{ name }}", {}).get("benchmark_repeats", 1),)
    threads: # optional
       config.get("{{ name }}", config["default_resources"])["threads"]
    container:
       config.get("{{ name }}", {}).get("container", config["default_container"])
    conda:
       "../envs/{{ name }}.yaml"
    message:
       "{rule}: Do stuff on {{ module_name }}/{rule}/{wildcards.sample}_{wildcards.unit}.input"
    wrapper:
        "..."