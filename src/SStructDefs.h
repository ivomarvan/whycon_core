#ifndef WHYCON__SSTRUCTDEFS_H
#define WHYCON__SSTRUCTDEFS_H

#include <stdio.h>

namespace whycon {

typedef struct
{
    float angle;    // axis rotation angle
    int id;         // marker decoded ID
    int edge_index;  // idx of starting edge
} SDecoded;


// this structure contains information related to image coordinates and dimensions of the detected pattern
typedef struct
{
    float x;			// center in image coordinates
    float y;			// center in image coordinates
    float angle,horizontal;	// orientation (not really used in this case, see the SwarmCon version of this software)
    int size;			// number of pixels
    int maxy,maxx,miny,minx;	// bounding box dimensions
    int mean;			// mean brightness
    int type;			// black or white ?
    float roundness;		// result of the first roundness test, see Eq. 2 of paper [1]
    float bwRatio;		// ratio of white to black pixels, see Algorithm 2 of paper [1]
    bool round;			// segment passed the initial roundness test
    bool valid;			// marker passed all tests and will be passed to the transformation phase
    float m0,m1;		// eigenvalues of the pattern's covariance matrix, see Section 3.3 of [1]
    float v0,v1;		// eigenvectors of the pattern's covariance matrix, see Section 3.3 of [1]
    float r0,r1;		// ratio of inner vs outer ellipse dimensions (used to establish ID, see the SwarmCon version of this class)
    int ID;			// pattern ID (experimental, see the SwarmCon version of this class)
    void dbg_print(int index, const char* msg="") {
        printf("=== SSegment ===================================================================================================\n");
        printf("%s\tID:%i, index=%i, valid=%i\n", msg, ID, index, valid);
        printf("x=%f, y=%f, angle=%f, horizontal=%f, size=%i\n", x, y, angle, horizontal, size);
        printf("maxy=%i, maxx=%i, miny=%i, minx=%i\n", maxy, maxx, miny, minx);
        printf("mean=%i, black_white=%i\n", mean, type);
        printf("roundness=%f, bwRatio=%f, round=%i\n", roundness, bwRatio, round);
        printf("m0=%f, m1=%f, v0=%f, v1=%f, r0=%f, r1=%f\n", m0, m1, v0, v1, r0, r1);
        printf("---------------------------------------------------------------------------------------------------------------------\n");
    }
} SSegment;

// which transform to use
typedef enum
{
    TRANSFORM_NONE,     //camera-centric
    TRANSFORM_2D,       //3D->2D homography
    TRANSFORM_3D,       //3D user-defined - linear combination of four translation/rotation transforms
    TRANSFORM_4D,       //3D user-defined - full 4x3 matrix
    TRANSFORM_INV,      //for testing purposes
    TRANSFORM_NUMBER
} ETransformType;

typedef struct
{
    float u, v;                 // real center in the image coords
    float x, y, z, d;           // position and distance in the camera coords
    float roll, pitch, yaw;     // fixed axis angles
    float angle;                // axis angle around marker's surface normal
    float n0, n1, n2;           // marker surface normal pointing from the camera
    float qx, qy, qz, qw;       // quaternion
    // ??? not used float roundness;            // segment roundness as calculated by 5 of [1]
    // ??? not used float bwratio;              // black/white area ratio
    // ??? not used int ID;                     // ID of marker
    void dbg_print(int index, const char* msg="") {
        printf("===== STrackedObject =================================================================================================\n");
        printf("%s index=%i\n", msg, index);
        printf("u=%f, v=%f (center in the image coords)\n", u, v);
        printf("x=%f, y=%f, z=%f, d=%f (position and distance in the camera coords)\n", x, y, z, d);
        printf("pitch=%f, roll=%f, yaw=%f (fixed axis angles)\n", pitch, roll, yaw);
        printf("angle=%f (axis angle around marker's surface normal)\n", angle);
        printf("n0=%f, n1=%f, n2=%f ( marker surface normal pointing from the camera)\n", n0, n1, n2);
        printf("qx=%f, qy=%f, qz=%f, qw%f (quaternion)\n", qx, qy, qz, qw);
        printf("---------------------------------------------------------------------------------------------------------------------\n");
    }
} STrackedObject;


typedef struct
{
    float u[2];     // retransformed x coords
    float v[2];     // retransformed y coords
    float n[2][3];  // both solutions of marker's surface normal
    float t[2][3];  // both solutions of position vector
} SEllipseCenters;

// rotation/translation model of the 3D transformation                                                                                                                  
typedef struct
{
    float orig[3];      // translation {x, y, z}
    float simlar[9];    // rotation description, similarity transformation matrix
} S3DTransform;

typedef struct
{
    bool valid;
    SSegment seg;
    STrackedObject obj;
} SMarker;


} // namespace whycon

#endif
