import os

import ESMF
import numpy as np


lons = np.arange(5, 350.1, 10)
lats  = np.arange(-85, 85.1, 10)

mg = ESMF.Manager(debug=True)

[lat, lon] = [1, 0]


srcgrid = ESMF.Grid(
    np.array([lons.size, lats.size]),
    coord_sys=ESMF.CoordSys.SPH_DEG,
    staggerloc=ESMF.StaggerLoc.CENTER,
    num_peri_dims=1,
    periodic_dim=0,
    pole_dim=1
)

srcGridCoordLon = srcgrid.get_coords(lon)
srcGridCoordLat = srcgrid.get_coords(lat)

slons_par = lons[srcgrid.lower_bounds[ESMF.StaggerLoc.CENTER][0]:srcgrid.upper_bounds[ESMF.StaggerLoc.CENTER][0]]
slats_par = lats[srcgrid.lower_bounds[ESMF.StaggerLoc.CENTER][1]:srcgrid.upper_bounds[ESMF.StaggerLoc.CENTER][1]]

lonm, latm = np.meshgrid(slons_par, slats_par, indexing='ij')

srcGridCoordLon[:] = lonm
srcGridCoordLat[:] = latm

lons = np.arange(2.5, 357.6, 5)
lats = np.arange(-87.5, 87.6, 5)
dstgrid = ESMF.Grid(
    np.array([lons.size, lats.size]),
    coord_sys=ESMF.CoordSys.SPH_DEG,
    staggerloc=ESMF.StaggerLoc.CENTER,
    num_peri_dims=1,
    periodic_dim=1,
    pole_dim=0
)

dstGridCoordLat = dstgrid.get_coords(lat)
dstGridCoordLon = dstgrid.get_coords(lon)

dlons_par = lons[dstgrid.lower_bounds[ESMF.StaggerLoc.CENTER][0]:dstgrid.upper_bounds[ESMF.StaggerLoc.CENTER][0]]
dlats_par = lats[dstgrid.lower_bounds[ESMF.StaggerLoc.CENTER][1]:dstgrid.upper_bounds[ESMF.StaggerLoc.CENTER][1]]

lonm, latm = np.meshgrid(dlons_par, dlats_par, indexing='ij')

dstGridCoordLon[:] = lonm
dstGridCoordLat[:] = latm

srcfield = ESMF.Field(srcgrid, name='srcfield', staggerloc=ESMF.StaggerLoc.CENTER)

dstfield = ESMF.Field(dstgrid, name='dstfield', staggerloc=ESMF.StaggerLoc.CENTER)
xctfield = ESMF.Field(dstgrid, name='xctfield', staggerloc=ESMF.StaggerLoc.CENTER)

gridLon = srcfield.grid.get_coords(lon, ESMF.StaggerLoc.CENTER)
gridLat = srcfield.grid.get_coords(lat, ESMF.StaggerLoc.CENTER)

srcfield.data[:,:] = (
    2.0 + np.cos(np.radians(srcGridCoordLat)[...])**2 *
    np.cos(2.0*np.radians(srcGridCoordLon)[...])
)

xctfield.data[:,:] = (
    2.0 + np.cos(np.radians(dstGridCoordLat)[...])**2 *
    np.cos(2.0*np.radians(dstGridCoordLon)[...])
)

dstfield.data[:] = 1e20


if ESMF.pet_count() > 1:
    regrid = ESMF.Regrid(srcfield, dstfield,
                         regrid_method=ESMF.RegridMethod.BILINEAR,
                         unmapped_action=ESMF.UnmappedAction.IGNORE)
else:
    if os.path.isfile(os.path.join(os.getcwd(), 'esmpy_example_weight_file.nc')):
        os.remove(os.path.join(os.getcwd(), 'esmpy_example_weight_file.nc'))

    mg.barrier()
    regrid = ESMF.Regrid(srcfield, dstfield, filename='esmpy_example_weight_file.nc',
            regrid_method=ESMF.RegridMethod.BILINEAR,
            unmapped_action=ESMF.UnmappedAction.IGNORE)

regrid = ESMF.RegridFromFile(srcfield, dstfield, 'esmpy_example_weight_file.nc')

dstfield = regrid(srcfield, dstfield)

num_nodes = np.prod(xctfield.data.shape[:])
relerr = 0
meanrelerr = 0
if num_nodes is not 0:
    relerr = np.sum(np.abs(dstfield.data - xctfield.data) /
                       np.abs(xctfield.data))
    meanrelerr = relerr / num_nodes

if ESMF.pet_count() > 1:
    from ESMF.util.helpers import reduce_val
    relerr = reduce_val(relerr, op=MPI.SUM)
    num_nodes = reduce_val(num_nodes, op=MPI.SUM)

if ESMF.local_pet() is 0:
    meanrelerr = relerr / num_nodes
    print ('ESMPy Grid Mesh Regridding Example')
    print ('  interpolation mean relative error = {0}'.format(meanrelerr))