def TEXTWITHATTRIBUTES (TEXTALIGNMENT='centre', TEXTANGLE=0, TEXTWIDTH=1.0, TEXTHEIGHT=2.0, TEXTSPACING=0.25):
    PRINT(TEXTALIGNMENT)
    ALIGN = IF([ K(TEXTALIGNMENT == 'centre'),
				 COMP([ APPLY, CONS([ COMP([ T(1), RAISE(DIV), CONS([ SIZE(1), K(-2) ]) ]), ID ]) ]),
				 IF([ K(TEXTALIGNMENT == 'right'),
					  COMP([ APPLY, CONS([ COMP([ T(1), RAISE(DIFF), SIZE(1) ]), ID ]) ]),
					  ID ]) ])
    HANDLE = CONS([
				COMP([ AA(S([1,2])([TEXTWIDTH/FONTWIDTH, TEXTHEIGHT/FONTHEIGHT])), charpols ]),
				K(T(1)(TEXTSPACING + TEXTWIDTH)) ])
    fn = COMP([ R([1,2])(TEXTANGLE), ALIGN, STRUCT, CAT, DISTR, HANDLE, CHARSEQ ])
    return fn

	function textWithAttributes(textalignment="centre", textangle=0, textwidth=1.0, textheight=2.0, textspacing=0.25)
		id = x->x
		align = if textalignment == 'centre'
					COMP([ APPLY, CONS([ COMP([ T(1), RAISE(DIV), CONS([ SIZE(1), K(-2) ]) ]), ID ]) ]),
				elseif textalignment == 'right'
					COMP([ APPLY, CONS([ COMP([ T(1), RAISE(DIFF), SIZE(1) ]), ID ]) ]),
				else
					id
				end
		handle = CONS([
					COMP([ AA( Lar.s(GL.textwidth/GL.fontwidth, GL.textheight/GL.fontheight) ), GL.charpols ]),
					GL.k(Lar.t(textwidth+textspacing,0)) ])

		fn = COMP([ R([1,2])(TEXTANGLE), ALIGN, STRUCT, CAT, DISTR, HANDLE, GL.charseq ])
		return fn
	end


		function textWithAttributes0(strand)
			mat = Lar.s(GL.textwidth/GL.fontwidth,GL.textheight/GL.fontheight)
			Lar.apply(Lar.r(textangle),
			COMP([ align(textalignment),
			   Lar.struct2lar,
			   Lar.Struct,
			   GL.cat,
			   GL.distr,
			   GL.cons([ GL.a2a(mat) ∘ GL.charpols,
					GL.k(Lar.t(textwidth+textspacing,0)) ]),
			   GL.charseq ]))(strand)
		end
		return textWithAttributes0
	end

	if __name__=="__main__":
	    VIEW(TEXT('PLASM'))
	    VIEW(TEXTWITHATTRIBUTES('centre',PI/4,0.1,0.4,0.05)('PLASM'))


"""
	COMP(Funs)

Compose an Array of functions.
```
julia> COMP([sin,cos,tan])(pi/4)
0.5143952585235492

julia> COMP([sin,cos,tan])(pi/4) == (sin∘cos)(1)
true
```
"""
function COMP(Funs)
	function ∘(f,g)
		function h(x)
			return f(g(x))
		end
		return h
	end
	return reduce(∘,Funs)
end



function lift(f)
	return funs-> COMP([f, CONS(funs)])
end

function raise(f)
	function raise0(args)
		return (issequence(isfun) ? lift(f) : f)(args)
	end
	return raise0
end


"""
	julia> isfun(x::Any)::Bool
# Example
```
julia> isfun(sin)
true

julia> isfun(x->2x)
true

julia> isfun("a string")
false
```
"""
isfun(x::Any)::Bool = isa(x, Function)



"""
```
julia> args = [sin,cos,tan]
3-element Array{Function,1}:
 sin
 cos
 tan

julia> isSequenceOf(isfun)(args)
true
```
"""
function isSequenceOf(predicate)
	function isSequenceof0(args)
		return (&)(map(predicate,args)...)
	end
	return isSequenceof0
end
