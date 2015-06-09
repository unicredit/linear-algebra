# Copyright 2015 UniCredit S.p.A.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

proc linearCombination[N: static[int]](a: float64, v, w: Vector64[N]): Vector64[N]  {. inline .} =
  new result
  dcopy(N, v.fp, 1, result.fp, 1)
  daxpy(N, a, w.fp, 1, result.fp, 1)

proc linearCombinationMut[N: static[int]](a: float64, v: var Vector64[N], w: Vector64[N])  {. inline .} =
  daxpy(N, a, w.fp, 1, v.fp, 1)

template rewriteLinearCombination*{v + `*`(w, a)}(a: float64, v, w: Vector64): auto =
  linearCombination(a, v, w)

template rewriteLinearCombinationMut*{v += `*`(w, a)}(a: float64, v: var Vector64, w: Vector64): auto =
  linearCombinationMut(a, v, w)