%Initialize the workspace
clear; format short e
syms x y z t
%%Display message so users know which variables to use
fprintf('Make sure that all equations are in terms of "x" "y" "z" or "t"!\n')

%%Ask for user inputs and check validities
%Force
F=input('Enter a force field, in 2 or 3 dimensions:\n');
%Check
if length(F)>3 | length(F)<2
    error('Must be in two or three dimensions.')
elseif isvector(F)==0
    error('Force must be a vector.')
end
%Curve
C=input('Enter a Curve, with same dimensions as field:\n');
%Check
if length(C)~=length(F)
    error('Curve and Field must be same size.')
elseif isvector(C)==0
    error('Curve must be a vector.')
end
%Bounds
bounds=input('Please state upper and lower t bounds, in that order:\n');
%Check
if length(bounds)~=2
    error('Need upper and lower bounds.')
elseif isvector(bounds)==0
    error('Need upper and lower bounds only.')
end
%Fix for order's sake
bounds=[min(bounds) max(bounds)];
%Orientation
or=input('Please enter an orientation, either CCW or CW:\n','s');
%Check
if ischar(or)==0
    error('Orientation must be a character array.')
end
%%Calculations
i=1;
%2-dimensional case
if length(F)==2 
    dr2=diff(C,t);
    new2=subs(F, [x y], C);
    FDR=new2(1)*dr2(1)+new2(2)*dr2(2);
%3-dimensional case
elseif length(F)==3 
    dr3=diff(C,t);
    new3=subs(F,[x y z],C);
    FDR=new3(1)*dr3(1)+new3(2)*dr3(2)+new3(3)*dr3(3);
end
%Actual integral
for k=bounds
    linint2=int(FDR,t);
    fin2(i)=subs(linint2,t,k);
    i=i+1;
end
%Switch answer to coincide with orientation
switch or
    case {'CCW', 'ccw'}
        Result=fin2(2)-fin2(1);
        fprintf('The value of your line integral is:\n')
        pretty(Result)
    case {'CW', 'cw'}
        Result=-(fin2(2)-fin2(1));
        fprintf('The value of your line integral is:\n')
        pretty(Result)
    otherwise
        Result=fin2(2)-fin2(1);
        fprintf('The value of your line integral (calculated using CCW orientation) is:\n %f\n')
        pretty(Result)
end
    