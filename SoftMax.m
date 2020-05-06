#!/usr/bin/octave-cli

## "Capa" sigmoide, que aplica la función logística
classdef SoftMax < handle
  properties
    
    ## Entradas
    inputs=[];
    ## Resultados después de la propagación hacia adelante
    outputs=[];
    ## Resultados después de la propagación hacia atrás
    gradient=[];
    
  endproperties

  methods
    ## Constructor ejecuta un forward si se le pasan datos
    function s=SoftMax()
      s.inputs=[];
      s.outputs=[];
      s.gradient=[];
    endfunction

    ## Propagación hacia adelante
    function y=forward(s,a)
      s.inputs=a;
      s.outputs = max(0,a);
      y=s.outputs;
      s.gradient = [];
    endfunction

    ## Propagación hacia atrás recibe dL/ds de siguientes nodos
    function backward(s,dLds)
      if (size(dLds)!=size(s.outputs))
        error("backward de ReLU no compatible con forward previo");
      endif
      
      localGrad = max(0,abs(s.inputs)./s.inputs);
      s.gradient = localGrad.*dLds;
      
    endfunction
  endmethods
endclassdef