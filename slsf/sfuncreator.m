classdef sfuncreator
    %SFUNCREATOR Creates a S-Function
    %   Detailed explanation goes here
    
    properties
        gcc_opt = '-O0'
    end
    
    methods
        
        
        function ret = go(obj)
            fprintf('Calling Csmith Generator...\n');
            
            atoz = char('a' : 'z');
            ret = atoz(randi([1 26], 1, 12));
            sfname = [ret '.c'];
            
            [status, cmdout] = system(['./csmith_gen.py --sfname ' sfname]);
        
            cmdout

            if status ~= 0
                disp('[!] Skipping this run as does not terminate.');
                throw(MException('SL:RandGen:CsmithNonZeroExitCode', 'CsmithGen.py returned non-zero exit code.'));
            end
            
            eval(['mex CFLAGS="\$CFLAGS -std=gnu99 -w" COPTIMFLAGS="' obj.gcc_opt, '" ' sfname ';']);
        end
        
    end
    
end

