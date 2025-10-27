## Resources

- for understanding ramifications of sampling and quantization: chapter 3 of
"The Scientist and Engineer's Guide to Digital Signal Processing" by Steven W.
Smith - free online.

## Sampling and Quantization

**sampling** converts the independent variable from continuous to discrete.

**quantization** converts the dependent variable from continuous to discrete.

### Max error

Any one sample in the digitized signal can have a maximum error of ±½ LSB
(Least Significant Bit, jargon for the distance between adjacent quantization
levels). 
- NOTE: I see that it can be half the quant step but I don't understand where
the LSB comes from

### Noise 

In most cases, quantization results in nothing more than the addition of a
specific amount of random noise to the signal.

When faced with the decision of how many bits are needed in a system, ask two
questions: (1) How much noise is already present in the analog signal? (2) How
much noise can be tolerated in the digital signal? 
- NOTE: I don't really understand this, but super interesting.

### PROPER sampling 

If you can exactly reconstruct the analog signal from the samples, you must
have done the sampling properly.

### Aliasing (FIGURE 3.3)

- NOTE: Aliasing results because the Afreq > Sfreq / 2 (Shannon-Nyquist) 
In (d), the analog frequency is pushed even higher to 0.95 of the sampling rate, with a
mere 1.05 samples per sine wave cycle. Do these samples properly represent the
data? No, they don't! The samples represent a different sine wave from the one
contained in the analog signal. In particular, the original sine wave of 0.95
frequency misrepresents itself as a sine wave of 0.05 frequency in the digital
signal. This phenomenon of sinusoids changing frequency during sampling is
called aliasing. Just as a criminal might take on an assumed name or identity
(an alias), the sinusoid assumes another frequency that is not its own. Since
the digital data is no longer uniquely related to a particular analog signal,
an unambiguous reconstruction is impossible.

### Shannon-Nyquist sampling theorem 

a continuous signal can be properly sampled, only if it does not contain
frequency components above one-half of the sampling rate.

If frequencies above this limit are present in the signal, they will be aliased
to frequencies between 0 and 1000 cycles/second, combining with whatever
information that was legitimately there.

DEF: In this book, "Nyquist rate" refers to half the sampling frequency

a digital signal cannot contain frequencies above one-half the sampling rate
(i.e. the Nyquist rate)

As shown by the zigzagging line in Fig. 3-4, every continuous frequency above
the Nyquist rate has a corresponding digital frequency between zero and
one-half the sampling rate. If there happens to be a sinusoid already at this
lower frequency, the aliased signal will add to it, resulting in a loss of
information. Aliasing is a double curse; information can be lost about the
higher and the lower frequency.
