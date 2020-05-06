function l=logsoft(x)
  a=exp(x);
  l=(1/sum(a))*a;
endfunction