function LineInt(field,vars,curve,var,tlow,thigh,or)
format short e;
%%Error messages
if isvector(field)==0 | isvector(curve)==0
    error('Arguments must be vectors.')
elseif length(field)~=length(vars)
    error('Please input correct number of variables.')
elseif size(field)>3 | size(field)<2
    error('2 or 3 dimensions, plz.')
elseif size(field)~=size(curve)
    error('Curve and field must match dimensions')
elseif isnumeric([tlow thigh])==0
    error('t values must be numbers, not strings.')
elseif nargin<4
    error('Need upper and lower t bounds, in that order.')
end
%%2-dimensional calculations
i=1;
if length(field)==2 
    dr2=diff(curve,var);
    new2=subs(field, vars, curve);
    FDR=new2(1)*dr2(1)+new2(2)*dr2(2);
elseif length(field)==3 
    dr3=diff(curve,var);
    new3=subs(field,vars,curve);
    FDR=new3(1)*dr3(1)+new3(2)*dr3(2)+new3(3)*dr3(3);
end
for k=[tlow thigh]
    linint2=int(FDR,var);
    fin2(i)=subs(linint2,var,k);
    i=i+1;
end
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
            
        
    






