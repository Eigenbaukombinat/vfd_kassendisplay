replacements = dict(
	a = chr(127),
	b = chr(66),
	c = chr(240),
	d = chr(68),
	e = chr(246),
	f = chr(159),
	g = chr(103),
	h = chr(72),
	i = chr(173),
	j = chr(74),
	k = chr(251),
	l = chr(124),
	m = chr(77),
	n = chr(181),
	o = chr(228),
	p = chr(186),
	q = chr(182),
	r = chr(237),
	s = chr(180),
	t = chr(188),
	u = chr(229),
	v = chr(118),
	w = chr(231),
	x = chr(200),
	y = chr(230),
	z = chr(90),
	ß = chr(177),
	ä = chr(132),
	ö = chr(148),
	ü = chr(129),
)


def fancy(txt):
	txt = txt.lower()
	for char in txt:
		repl = replacements.get(char)
		if repl is not None:
			txt = txt.replace(char, repl)
	return txt