## Copyright (C) 2020 Pablo Alvarado
##
## Este archivo forma parte del material del Proyecto 1 del curso:
## EL5852 Introducción al Reconocimiento de Patrones
## Escuela de Ingeniería Electrónica
## Tecnológico de Costa Rica

## "Capa" fullyconnected (sin sesgo)
##
## Este código se da como ejemplo de implementación de una capa.
## 
## En principio, X es una matriz de diseño que tiene a los datos
## en sus FILAS.  Esta es la convención.  Sin embargo, W lo que hace 
## es multiplicar a un vector (columna) x para producir al vector 
## columna y con la salida (y=Wx).  
##
## Queremos mantener la lógica de que tanto X como Y contendrán a los
## vectores de entrada y salida en sus filas, por lo que 
##   Y' = W X'   =>   Y = X W'
##
## Esto está implementado para que X y Y mantengan sus naturalezas
## de matrices de diseño, y que W tenga los pesos tal que y=Wx.  
##
## Si el método forward recibe un solo vector (columna) x, el cálculo
## se ajusta adecuadamente para producir y.  De otro modo, se asume que
## la entrada es una matriz convencional de diseño.
classdef fullyconnected < handle
  properties
    ## Entrada de parametros en la propagación hacia adelante
    inputsW=[];
    ## Entrada de valores en la propagación hacia adelante
    inputsX=[];
    
    ## Resultados después de la propagación hacia adelante
    outputs=[];
    ## Resultados después de la propagación hacia atrás
    gradientW=[];
    gradientX=[];
  endproperties

  methods
    ## Constructor inicialica todo vacío
    function s=fullyconnected()
      s.inputsX=[];
      s.inputsW=[];
      s.outputs=[];
      s.gradientX=[];
      s.gradientW=[];
    endfunction

    ## Propagación hacia adelante realiza W*x
    function y=forward(s,W,X)
      if (isreal(W) && ismatrix(W) && isreal(X) && ismatrix(X))
        s.inputsW=W;
        if (columns(X)==1)
          s.inputsX=[1;X];
          s.outputs = W*[1;X];
        else
          s.inputsX=[ones(rows(X),1),X];
          s.outputs =[ones(rows(X),1),X]*W';
        endif
        y=s.outputs;
        s.gradientX = [];
        s.gradientW = [];
      else
        error("fullyconnected espera matriz y vector de reales");
      endif
    endfunction

    ## Propagación hacia atrás recibe dL/ds de siguientes nodos
    function backward(s,dLds)
      if (columns(dLds)==1)
        s.gradientW = dLds*s.inputsX';
        s.gradientX = s.inputsW(:,2:end)'*dLds;
      else
        s.gradientW = dLds'*s.inputsX;
        s.gradientX = dLds*s.inputsW(:,2:end);
      endif
    endfunction
  endmethods
endclassdef
