
#ifndef SAMPLING_PERIOD
	#error "SAMPLING_PERIOD is not defined !"
#endif

#ifndef concrete_t
	#error "concrete_t is not defined !"
#endif

#ifndef ssDim
	#error "ssDim is not defined !"
#endif



#define RK4_NINT 5
#define RK4_H ((((concrete_t)SAMPLING_PERIOD)/((concrete_t)RK4_NINT)))

void rk4OdeSolver(concrete_t* xx, const concrete_t* x, const concrete_t* u, char mode);
void rk4OdeSolver(concrete_t* xx, const concrete_t* x, const concrete_t* u, char mode) {
	concrete_t k0[ssDim];
	concrete_t k1[ssDim];
	concrete_t k2[ssDim];
	concrete_t k3[ssDim];
	concrete_t tmp[ssDim];

	for (unsigned int i = 0; i < ssDim; i++)
		xx[i] = x[i];

	for (unsigned int t = 0; t < RK4_NINT; t++) {

		if (mode == 'x')
			post_dynamics(k0, xx, u);
		else
			radius_dynamics(k0, xx, u);

		for (unsigned int i = 0; i < ssDim; i++)
			tmp[i] = xx[i] + RK4_H / 2.0f*k0[i];

		if (mode == 'x')
			post_dynamics(k1, tmp, u);
		else
			radius_dynamics(k1, tmp, u);

		for (unsigned int i = 0; i < ssDim; i++)
			tmp[i] = xx[i] + RK4_H / 2.0f*k1[i];

		if (mode == 'x')
			post_dynamics(k2, tmp, u);
		else
			radius_dynamics(k2, tmp, u);

		for (unsigned int i = 0; i < ssDim; i++)
			tmp[i] = xx[i] + RK4_H * k2[i];

		if (mode == 'x')
			post_dynamics(k3, tmp, u);
		else
			radius_dynamics(k3, tmp, u);

		for (unsigned int i = 0; i < ssDim; i++)
			xx[i] = xx[i] + (RK4_H / 6.0f)*(k0[i] + 2.0f*k1[i] + 2.0f*k2[i] + k3[i]);

	}
}