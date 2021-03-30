#ifndef WHYCON__CNECKLACE_H
#define WHYCON__CNECKLACE_H

#include <stdlib.h>
#include <math.h>
#include <stdio.h>
#include "SStructDefs.h"

namespace whycon {

typedef struct {
    int id;
    int rotation;
    int hamming;
} SNecklace;


class CNecklace {

    public:
        CNecklace(int id_bits, int id_samples, int minimalHamming = 1, bool debug = false);

        ~CNecklace();

        SNecklace get(int sequence, bool probabilistic = false, float confidence = 1.0);

        int verifyHamming(int a[], int id_bits, int len);

        float observationEstimation(float confidence);

        SDecoded decode(char *code, char *realCode, int max_index, float segmentV0, float segmentV1);

    private:
        SNecklace unknown;      // default unknown ID
        SNecklace *idArray;     // precalculated IDs

        float* probArray;       // probability for each ID
        int maxID;              // max ID used for Bayes probability
        int id_samples;          // id_samples to determine black/white signal
        int length;             // number of ID id_bits
        int idLength;           // amount of all possible IDs
        bool debug;             // debugging the class

        int getEstimatedID();

        int getHamming(int a, int b);

        int getMinimalHamming(int a, int len);
};

} // namespace whycon

#endif
