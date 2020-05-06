#!/usr/bin/octave-cli

## "Capa" sigmoide, que aplica la función logística
classdef ReLu < handle
  properties    
    ## Resultados después de la propagación hacia adelante
    outputs=[];
    ## Resultados después de la propagación hacia atrás
    gradient=[];
  endproperties

  methods
    ## Constructor ejecuta un forward si se le pasan datos
    function s=ReLu()
      s.outputs=[];
      s.gradient=[];
    endfunction

    ## Propagación hacia adelante
    function y=forward(s,a)
      s.outputs = max(0,a);
      y=s.outputs;
      s.gradient = [];
    endfunction

    ## Propagación hacia atrás recibe dL/ds de siguientes nodos
    function backward(s,dLds)
      if (size(dLds)!=size(s.outputs))
        error("backward de sigmoide no compatible con forward previo");
      endif
      localGrad = fU(0,s.outputs);
      s.gradient = localGrad.*dLds;
    endfunction
  endmethods
endclassdef
