

syms z2
eqn=1+z2+z2.^2./2+z2.^3./6+z2.^4./24==1

z=solve(eqn,z2);