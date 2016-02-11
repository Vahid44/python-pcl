
cimport pcl_defs as cpp
cimport pcl_filters as pclfil

cdef class PassThroughFilter:
    """
    Passes points in a cloud based on constraints for one particular field of the point type
    """
    cdef pclfil.PassThrough_t *me
    def __cinit__(self):
        self.me = new pclfil.PassThrough_t()
    def __dealloc__(self):
        del self.me

    def set_filter_field_name(self, field_name):
        cdef bytes fname_ascii
        if isinstance(field_name, unicode):
            fname_ascii = field_name.encode("ascii")
        elif not isinstance(field_name, bytes):
            raise TypeError("field_name should be a string, got %r"
                            % field_name)
        else:
            fname_ascii = field_name
        self.me.setFilterFieldName(string(fname_ascii))

    def set_filter_limits(self, float filter_min, float filter_max):
        self.me.setFilterLimits (filter_min, filter_max)

    def filter(self):
        """
        Apply the filter according to the previously set parameters and return
        a new pointcloud
        """
        cdef PointCloud pc = PointCloud()
        self.me.filter(pc.thisptr()[0])
        return pc
