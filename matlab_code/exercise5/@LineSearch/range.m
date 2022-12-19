function alpha = range(obj, al, a, b)
%RANGE

if al < a
    alpha = a;
    return;
elseif al > b
    alpha = b;
    return;
else
    alpha = al;
    return;
end
end

