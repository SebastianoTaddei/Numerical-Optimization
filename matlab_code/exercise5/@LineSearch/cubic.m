function alpha = cubic(obj, fx0, dfx0_p, fx_next, al, fx_prev, al_prev)
%CUBIC Cubic interpolation for the next step

den = al^2*al_prev^2*(al - al_prev);
a   = (al_prev^2*(fx_next - fx0 - al*dfx0_p) - al^2*(fx_prev - fx0 - al_prev*dfx0_p))/den;
b   = (-al_prev^3*(fx_next - fx0 - al*dfx0_p) + al^3*(fx_prev - fx0 - al_prev*dfx0_p))/den;

if a == 0
    alpha = -dfx0_p/(2*b);
    return;
else
    d = b^2 - 3*a*dfx0_p;
    alpha = (-b + sqrt(d))/(3*a);
    return;
end

end

