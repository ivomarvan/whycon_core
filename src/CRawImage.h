#ifndef WHYCON__CRAWIMAGE_H
#define WHYCON__CRAWIMAGE_H

#include "SStructDefs.h"

namespace whycon {

/**
@author Tom Krajnik
*/


class CRawImage
{

public:

  CRawImage(int width, int height, int bpp = 3);
  CRawImage(unsigned char* new_data, int width, int height, int bpp);

  ~CRawImage();

  void swapRGB();

  void updateImage(unsigned char* new_data, int width, int height, int bpp);

  void drawTimeStats(int eval_time, int num_markers);

  void drawStats(SMarker &marker, bool trans_2D);

  void drawGuideCalibration(int calib_num, float dim_x, float dim_y);



  void plotLine(int x, int y);

  void plotCenter();

  double getOverallBrightness(bool upperHalf);
  
  int width_;      // image width
  int height_;     // image height
  int size_;       // image size = width * height * bpp
  int bpp_;        // image id_bits per pixel

  unsigned char* data_;  // image buffer

  private:
    bool ownData_;
};

} // namespace whycon

#endif
