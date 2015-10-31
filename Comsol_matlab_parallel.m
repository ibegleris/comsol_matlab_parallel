clear all
%%% This script demostrates a way to run a comsol model in parallel.
%%% It makes use of the matlab/comsol server interface and the matlab parallel toolbox.
%%% This code has been tested on a Linux machine and makes use of bash, sorry no windows version.

cores= 4; % The number of cores Needed
addpath('/usr/local/comsol51/multiphysics/mli/') % adding the path to Mphstart

%% Opening the parpool as usual
myCluster=parcluster('local');
myCluster.NumWorkers=cores;
parpool(myCluster,cores);

%% Linking each matlab port to a seperate comsol server
parfor i=1:cores
    t = getCurrentTask();
    comsolPort = t.ID;
    system( ['comsol -np 1 server -silent -port ' num2str(3000+comsolPort) ' &'] );
    disp(['worker ' num2str(comsolPort) ' opening port ' num2str(3000+comsolPort)])
    pause(5)
    mphstart(3000+comsolPort)
end
N = 4;
parfor i =  1:1:N
    Your_comsol_function()
end

delete(gcp)
    


