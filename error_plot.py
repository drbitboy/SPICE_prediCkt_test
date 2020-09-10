import os
import sys
from math import cos
import spiceypy as sp
try: import matplotlib.pyplot as plt
except: pass

do_debug = 'DEBUG' in os.environ

def do_main(argv):

  sp.kclear()
  halfpi,dpr = sp.halfpi(),sp.dpr()

  fnck = 'out.bc'
  target = 'TEMPEL 1'
  frame = 'DIF_SPACECRAFT'
  for arg in argv:
    if arg.startswith('--ck='):
      fnck = arg[5:]
    elif arg.startswith('--target='):
      target = arg[9:]
    elif arg.startswith('--k='):
      sp.furnsh(arg[4:])
    else:
      assert False,'Unknown argument [{0}]'.format(arg)

  frameid = sp.gipool('FRAME_{0}'.format(frame),0,1)[0]
  scid = sp.gipool('CK_{0}_SPK'.format(frameid),0,1)[0]
  scname = sp.bodc2s(scid,99)
  cover = sp.stypes.SPICEDOUBLE_CELL(200)
  sp.scard(0,cover)
  cover = sp.ckcov(fnck,frameid,False,"INTERVAL",0.0,"TDB")
  sp.furnsh(fnck)
  vbore = sp.vpack(-1,0,0)
  vorbitnorm = sp.vpack(0,1,0)
  for ipair in range(sp.wncard(cover)):
    et0,etend = sp.wnfetd(cover,0)

    etlast,ettca,niter = et0,(et0+etend)*0.5,0

    while ettca != etlast and niter < 20:
      etlast = ettca
      state6 = sp.spkezr(target,ettca,"j2000","none",scname)[0]
      vpos,vvel = state6[:3],state6[3:]
      det = sp.vdot(vvel,vpos) / sp.vdot(vvel,vvel)
      ettca -= det
      niter += 1

    print(dict(TCAtdb=sp.etcal(ettca,99),niter=niter,))

    et = et0
    ets,boreerrs,orbitnormerrs = list(),list(),list()
    while et <= etend:
      state6 = sp.spkezr(target,et,frame,"none",scname)[0]
      vpos,vvel = state6[:3],state6[3:]
      ets.append(et-et0)
      boreerrs.append(dpr*sp.vsep(vbore,vpos))
      orbitnormerrs.append(dpr*(sp.vsep(vbore,vorbitnorm)-halfpi))
      et += max([0.01,0.1*abs(cos(sp.vsep(vpos,vvel)))])
    try:
      plt.plot(ets,orbitnormerrs,'o',label='Orbit normal error')
      plt.plot(ets,boreerrs,'o',label='Boresight error')
      plt.axvline(ettca-et0,label='TCA')
      plt.xlabel('Time, s past {0} TDB'.format(sp.etcal(et0,99)))
      plt.ylabel('Error, deg')
      plt.legend(loc='best')
      plt.show()
    except:
      if do_debug:
        import traceback as tb
        tb.print_exc()
      print(boreerrs[::1000])
      print(orbitnormerrs[::1000])

if "__main__" == __name__:
  do_main(sys.argv[1:])
