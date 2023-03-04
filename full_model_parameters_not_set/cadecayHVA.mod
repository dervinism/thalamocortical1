TITLE Mechanism for submembranal Ca2+ concentration (cai)

COMMENT
    Takes into account:
        - increase of cai due to calcium currents
        - extrusion of calcium with a simple first order equation

    Parameters:
        - depth: depth of the shell beneath the membran (in um). Should be
          no more than the radius of the cell.
        - cainf: equilibrium concentration of calcium (TC: 23e-6 mM; NRT:
          39e-6 mM)
        - taux: time constant of calcium extrusion (5 ms)

    Written by Martynas Dervinis @ Cardiff University, 2013
        (martynas.dervinis@gmail.com).
ENDCOMMENT

NEURON {
	SUFFIX cadHVA
	USEION caHVA READ icaHVA, caHVAi WRITE caHVAi VALENCE 2
	RANGE depth, cainf, taux
}

UNITS {
	(molar) = (1/liter)
	(mM)	= (millimolar)
	(um)	= (micron)
	(mA)	= (milliamp)
	(msM)	= (ms mM)
}

CONSTANT {
	FARADAY = 96489	(coul)
}

PARAMETER {
	depth	= 1     (um)		: depth of shell
	taux	= 5     (ms)		: rate of calcium removal
	cainf	= 50e-6 (mM)
}

STATE {
	caHVAi	(mM) 
}

INITIAL {
	caHVAi = cainf
}

ASSIGNED {
	icaHVA          (mA/cm2)
	drive_channel	(mM/ms)
}

BREAKPOINT {
	SOLVE state METHOD derivimplicit
}

DERIVATIVE state {
    drive_channel =  - (10000) * icaHVA / (2 * FARADAY * depth) : 10000 comes from depth being in um instead of cm
    if (drive_channel <= 0) { drive_channel = 0 }	: cannot pump inward
    caHVAi' = drive_channel + (cainf-caHVAi)/taux
}
