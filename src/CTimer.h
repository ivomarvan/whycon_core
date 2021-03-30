#ifndef WHYCON__CTIMER_H
#define WHYCON__CTIMER_H

/**
@author Tom Krajnik
*/

#include <sys/time.h>
#include <stdlib.h>

namespace whycon {


#define TIMEOUT_INTERVAL 40000

class CTimer
{
	public:
		CTimer(int timeOut = TIMEOUT_INTERVAL);
		~CTimer();

		void reset(int timeOut = TIMEOUT_INTERVAL);
		bool paused();

		int pause();
		int start();
		int getTime();
		bool timeOut();

		int64_t getRealTime();
	private:
		int startTime;
		int pauseTime;
		bool running;
		int timeoutInterval;
};

} // namespace whycon

#endif
