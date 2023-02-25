TITLE High threshold calcium current in thalamocortical cells

COMMENT

    The model equations are taken from [1].

    References:
    [1] McCormick, D.A. and Huguenard, J.R. A model of the
        electrophysiological properties of thalamocortical relay neurons.
        Jounal of Neurophysiology 68: 1384-1400, 1992.

ENDCOMMENT

NEURON {
	SUFFIX ihvaNRT
    USEION ca READ cai, cao WRITE ica
	RANGE pcabar, m_inf, tau_m, act, shift
}

UNITS {
	(molar) = (1/liter)
	(mV) =	(millivolt)
	(mA) =	(milliamp)
	(mM) =	(millimolar)

	FARADAY = (faraday) (coulomb)
	R = (k-mole) (joule/degC)
}

PARAMETER {
	v                   (mV)
	celsius	= 35        (degC)
	pcabar	= 1.53e-4	(cm/s)                                              : maximum Permeability. 1st activation curve: 1.53e-4; 2nd: 1.1e-4
	cai	= 50e-6         (mM)
	cao	= 1.5           (mM)
	q10	= 3
    act = 1                                                                 : switch between steady state activation curves
    shift = 15
}

STATE {
	m
}

ASSIGNED {
	ica       (mA/cm2)
	m_inf
	tau_m     (ms)
}

BREAKPOINT {
	SOLVE castate METHOD cnexp
	ica = pcabar * m*m * ghk(v, cai, cao)
}

INITIAL {
	gates(v)
    m = m_inf
}

DERIVATIVE castate {
	gates(v)
    m' = (m_inf - m) / tau_m
}

UNITSOFF
PROCEDURE gates(v(mV)) {                                                    : computes gating functions and other constants at current v
                                                                            : call once from HOC to initialize inf at resting v
    LOCAL  q10, z, a, b
    TABLE m_inf, tau_m DEPEND celsius FROM -120 TO 80 WITH 200

    UNITSOFF
    q10 = 3^((celsius - 21) / 10)

    if (act == 1) {                                                         : activation system
        z = (1e-3)*2.25*FARADAY/(R*(celsius+273.15))
        m_inf = 1/(1 + exp(-z*(v + 19.48 - shift)))
    } else if (act == 2) {
        z = (1e-3)*2.75*FARADAY/(R*(celsius+273.15))
        m_inf = 1/(1 + exp(-z*(v + 25.19 - shift)))
    }
    a = 1.6/(1 + exp(-0.0072*(v - shift - 5)))
    b = 0.02*(v - shift + 8.69)/(exp((v - shift + 8.69)/5.36) - 1)
    tau_m = 1/(a + b) / q10
}

FUNCTION ghk(v(mV), ci(mM), co(mM)) (.001 coul/cm3) {
	LOCAL z, eci, eco
	z = (1e-3)*2*FARADAY*v/(R*(celsius+273.15))
	eco = co*efun(z)
	eci = ci*efun(-z)
	ghk = (.001)*2*FARADAY*(eci - eco)
}

FUNCTION efun(z) {
	if (fabs(z) < 1e-4) {
		efun = 1 - z/2
	}else{
		efun = z/(exp(z) - 1)
	}
}
UNITSON
