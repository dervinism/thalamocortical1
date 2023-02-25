TITLE T-type Ca2+ current I_T

COMMENT
    Model described in [1] and maximal conductance adjusted to 2-10 nA.

    References:
    [1] Williams, S.R., Toth, T.I., Turner, J.P., Hughes, S.W., Crunelli, V.
        The window component of the low threshold Ca2+ current produces
        input signal amplification and bistability in cat and rat
        thalamocortical neurones. Journal of Physiology, 505: 689-705, 1997.
   
ENDCOMMENT

NEURON {
	SUFFIX it
	USEION ca READ eca WRITE ica
	RANGE gcabar, m_inf, tau_m, shift_m, h_inf, tau_h, shift_h, adj
}

UNITS {
	(mV) =	(millivolt)
	(mA) =	(milliamp)
}

PARAMETER {
	v (mV)
	celsius	= 35 (degC)
    eca = 180 (mV)
	gcabar	= 0.001	(mho/cm2)
    adj = 0
    m_shift = 0 (mV)
    h_shift = 0 (mV)
}

STATE {
	m h
}

ASSIGNED {
	ica	(mA/cm2)
	m_inf
	tau_m (ms)
	h_inf
	tau_h (ms)
}

BREAKPOINT {
	SOLVE states METHOD cnexp
	ica = gcabar * m^3 * h * (v - eca)
}

INITIAL {
	gates(v)
	m = m_inf
    h = h_inf
}

DERIVATIVE states {
	gates(v)
    m' = (m_inf - m) / tau_m
	h' = (h_inf - h) / tau_h
}

: Procedures
PROCEDURE gates(v(mV)) {                                                    : computes gating functions and other constants at current v
                                                                            : call once from HOC to initialize inf at resting v
    LOCAL  q10
    TABLE m_inf, h_inf, tau_m, tau_h
        DEPEND celsius FROM -100 TO 100 WITH 200

    UNITSOFF
    q10 = 3^((celsius - 35) / 10)

    if (adj) {                                                              : activation system
        if ((v-m_shift) > -75) {
            tau_m = (2.44 + 0.02506 * exp(-0.0984 * (v-m_shift))) / q10
        } else {
            tau_m = 42
        }
    } else {
        tau_m = (2.44 + 0.02506 * exp(-0.0984 * (v-m_shift))) / q10
    }
    m_inf = 1 / (1 + exp(-((v-m_shift) + 63) / 7.8))

    if (adj) {                                                              : inactivation system
        if ((v-h_shift) > -85) {
            tau_h = (7.66 + 0.02868 * exp(-0.1054 * (v-h_shift))) / q10
        } else {
            tau_h = 230
        }
    } else {
        tau_h = (7.66 + 0.02868 * exp(-0.1054 * (v-h_shift))) / q10
    }
    h_inf = 1 / (1 + exp(((v-h_shift) + 83.5) / 6.3))
}


UNITSON