function val = evaluate_poly(x,y,z,fit)

val = 0;
for i = 1:numel(fit.px)
    val = val + fit.vals(i)*( x.^fit.px(i).*y.^fit.py(i).*z.^fit.pz(i));
end
