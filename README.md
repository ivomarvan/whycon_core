## WhyCon ![Whycon tag with ID](whycon-code.jpg)



### A precise, efficient and low-cost localization system 

_WhyCon_ is a version of a vision-based localization system that can be used with low-cost web cameras, and achieves millimiter precision with very high performance.
The system is capable of efficient real-time detection and precise position estimation of several circular markers in a video stream. 
It can be used both off-line, as a source of ground-truth for robotics experiments, or on-line as a component of robotic systems that require real-time, precise position estimation.
_WhyCon_ is meant as an alternative to widely used and expensive localization systems. It is fully open-source.
_WhyCon-orig_ is WhyCon's original, minimalistic version that was supposed to be ROS and openCV independent.


The _WhyCon_ system was developed as a joint project between the University of Buenos Aires, Czech Technical University and University of Lincoln, UK.
The main contributors were [Matias Nitsche](https://scholar.google.co.uk/citations?user=Z0hQoRUAAAAJ&hl=en&oi=ao), [Tom Krajnik](http://scholar.google.co.uk/citations?user=Qv3nqgsAAAAJ&hl=en&oi=ao) and [Jan Faigl](https://scholar.google.co.uk/citations?user=-finD_sAAAAJ&hl=en). Each of these contributors maintains a slightly different version of WhyCon.

## History of the repo

There are many implementations of this idea on GitHub. Because they come from the scientific environment, they are at different stages of development and with different modifications.
The goal of this implementation is to enable the development of the core of this idea as an independent library that can be used by other projects.

The basis for this library is the implementation from https://github.com/jiriUlr/whycon-ros.

There is a fully functional reproduction of individual marks in the image, as well as their identification (WhyCode).

## Other significant implementations
| WhyCon version  | Application | Main features | Maintainer|
| --------------- | ----------- | ------ | ----- |
| [WhyCon-orig](../../) | general | 2D, 3D, ROS, lightweight, autocalibration | [Tom Krajnik](http://scholar.google.co.uk/citations?user=Qv3nqgsAAAAJ&hl=en&oi=ao)|
| [WhyCon-ROS](https://github.com/lrse/whycon) | general | 2D, ROS | [Matias Nitsche](https://scholar.google.co.uk/citations?user=Z0hQoRUAAAAJ&hl=en&oi=ao) |
| [SwarmCon](https://github.com/gestom/CosPhi/tree/master/Localization) | μ-swarms | 2D, individual IDs, autocalibration | [Tom Krajnik](http://scholar.google.co.uk/citations?user=Qv3nqgsAAAAJ&hl=en&oi=ao) |
| [Caspa-WhyCon](http://robotics.fel.cvut.cz/faigl/caspa/) | UAVs | embedded, open HW-SW solution | [Jan Faigl](https://scholar.google.co.uk/citations?user=-finD_sAAAAJ&hl=en) |
| [Social-card](https://github.com/strands-project/strands_social/tree/hydro-devel/social_card_reader) | HRI | ROS, allows to command a robot | [Tom Krajnik](http://scholar.google.co.uk/citations?user=Qv3nqgsAAAAJ&hl=en&oi=ao) |

#### Where is it described ?

<i>WhyCon</i> was first presented on International Conference on Advanced Robotics 2013 [[2](#references)], later in the Journal of Intelligent and Robotics Systems [[1](#references)] and finally at the Workshop on Open Source Aerial Robotics during the International Conference on Intelligent Robotic Systems, 2015 [[3](#references)]. Its early version was also presented at the International Conference of Robotics and Automation, 2013 [[4](#references)]. An extension of the system, which used a necklace code to add ID's to the tags, achieved a best paper award at the SAC 2017 conference [[5](#references)].
If you decide to use this software for your research, please cite <i>WhyCon</i> using the one of the references provided in this [bibtex](http://raw.githubusercontent.com/wiki/gestom/CosPhi/papers/WhyCon.bib) file.

-----

### <a name="dependencies">Dependencies</a>

* <b>opencv</b>

### <a name="build">How to build and install</a>
####In general
To see a current variable setting of Makefile you can call 
`make info`

If you want to set a parameter, you can do it as follows
`make info USE_OPENCV_FROM_PYTHON=1`
(make USE_OPENCV_FROM_PYTHON=1)

####OpenCv and other (Python for example)
Unfortunately, the current implementation is dependent on OpenCV. 
If you expect to use the library with another application/library (such as Python), 
you need to use the **same version of the OpenCV** library.

If the variable USE_OPENCV_FROM_PYTHON = 1 (default is 0) 
the makefile tries to find OpenCV, which is in the appropriate version of Python.

If you use a **virtual** Python **environment**, you must **activate** it during the compilation.

(For example 
`conda activate <your enviroment>`
or `source venv/bin/activate`
, ...)

####Compilation and linking

`make`

or (for Python, inside of Python enviroment ) 

`make USE_OPENCV_FROM_PYTHON=1` 


#### <a name="install">Install</a>
`sudo make install`


#### <a name="uninstall">Uninstall</a>
`sudo make uninstall`

### <a name="usecases">Projects that produce this library</a>
* <a href="https://github.com/ivomarvan/pywhycon">Python wrapper for whycon (vision-based localization system)</a>

### <a name="todo">To Do List</a>
* Transfer hidden parameters from code to configurations.
* Add tests.  
* Remove the dependency on opencv (used mainly for coordinate transformation).

### References

1. T. Krajník, M. Nitsche et al.: <b>[A Practical Multirobot Localization System.](http://raw.githubusercontent.com/wiki/gestom/CosPhi/papers/2015_JINT_whycon.pdf)</b> Journal of Intelligent and Robotic Systems (JINT), 2014. [[bibtex](http://raw.githubusercontent.com/wiki/gestom/CosPhi/papers/2015_JINT_whycon.bib)].
2. T. Krajník, M. Nitsche et al.: <b>[External localization system for mobile robotics.](http://raw.githubusercontent.com/wiki/gestom/CosPhi/papers/2013_icar_whycon.pdf)</b> International Conference on Advanced Robotics (ICAR), 2013. [[bibtex](http://raw.githubusercontent.com/wiki/gestom/CosPhi/papers/2013_icar_whycon.bib)].
3. M. Nitsche, T. Krajník et al.: <b>[WhyCon: An Efficent, Marker-based Localization System.](http://raw.githubusercontent.com/wiki/gestom/CosPhi/papers/2015_irososar_whycon.pdf)</b> IROS Workshop on Open Source Aerial Robotics, 2015. [[bibtex](http://raw.githubusercontent.com/wiki/gestom/CosPhi/papers/2015_irososar_whycon.bib)].
4. J. Faigl, T. Krajník et al.: <b>[Low-cost embedded system for relative localization in robotic swarms.](http://ieeexplore.ieee.org/xpls/abs_all.jsp?arnumber=6630694)</b> International Conference on Robotics and Automation (ICRA), 2013. [[bibtex](http://raw.githubusercontent.com/wiki/gestom/CosPhi/papers/2013_icra_whycon.bib)].
5. P. Lightbody, T. Krajník et al.: <b>[A versatile high-performance visual fiducial marker detection system with scalable identity encoding.](http://eprints.lincoln.ac.uk/25828/1/4d0bd9e8a3b3b5ad6ca2d56c1438fbbc.pdf)</b>Symposium on Applied Computing, 2017.[[bibtex](http://raw.githubusercontent.com/wiki/gestom/CosPhi/papers/2017_sac_whycon.bib)].

### Acknowledgements

The development of this work is currently supported by the Czech Science Foundation project 17-27006Y _STRoLL_.
In the past, the work was supported by EU within its Seventh Framework Programme project ICT-600623 _STRANDS_.
The Czech Republic and Argentina have given support through projects 7AMB12AR022, ARC/11/11 and 13-18316P.
We sincerely acknowledge [Jean Pierre Moreau](http://jean-pierre.moreau.pagesperso-orange.fr/infos.html) for his excellent libraries for numerical analysis that we use in our project. 
