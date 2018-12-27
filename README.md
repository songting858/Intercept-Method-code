This directory includes the NEURON code (data generation) and the Matlab code (data processing) for illustrating the effectiveness of the intercept method in the determination of effective conductances using somatic voltage clamp. The detailed description of the NEURON model can be found in the file Model details.pdf.

Neuron morphology: n128.hoc, apical_dendrite.hoc, apical_trunk.hoc, axon_sections.hoc, basal_dendrite.hoc, radiatum.hoc, whole_dendrites.hoc. Active ion channels: na3.mod, nax.mod, kdrca1.mod, kaprox.mod, kadist.mod, h.mod. Transmitter receptors: synexp.mod. 

Main programs: pas_parameter_measure.hoc, pair_EI_Vclamp.hoc, multi_EI_Vclamp.hoc, transferfunc.hoc, plot_KES_KSS.hoc, plot_spots.hoc 

Run the program "pas_parameter_measure.hoc" to generate voltage traces in response to step currents. The data will be processed to obtain the parameters of leak conductance and effective neuronal surface area in the corresponding point neuron model in the Matlab program "pas_parameter_measure.m". The goodness of the fitted parameters will be evaluated in the Matlab program "pas_parameter_evaluation.m".

Run the program "pair_EI_Vclamp.hoc" and "multi_EI_Vclamp.hoc" to generate voltage and current data in the presence of voltage clamp for the case of a pair of E-I inputs and multiple E-I inputs respectively. The data will be processed to determine the effective excitatory and inhibitory conductances in the Matlab program "cond_estmate_vclamp.m". Run the program "plot_spots.hoc" to plot the spatial distribution of multiple synaptic input locations on the dendritic tree for the case of multiple E-I inputs. 

Run the program "transferfunc.hoc" followed by "plot_KES_KSS.hoc" to plot the spatial profile of the ratio between K_ES and K_SS on the dendritic tree. 

Under the windows system, use the “mknrndll” command to compile the mod files, and double-click the target program for running. 
Note: The programs are tested in NEURON 7.4.

Songting Li 
songting@sjtu.edu.cn 
Dec. 27, 2018
