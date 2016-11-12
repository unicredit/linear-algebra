# Copyright 2016 UniCredit S.p.A.
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

template cumulate(v, result, N: typed): auto =
  result[0] = v[0]
  for i in 1 .. < N:
    result[i] = result[i - 1] + v[i]

proc cumsum*[N: static[int]](v: Vector32[N] or Vector64[N]): type(v) =
  new result
  cumulate(v, result, N)

proc cumsum*(v: DVector32): DVector32 =
  result = newSeq[float32](v.len)
  cumulate(v, result, v.len)

proc cumsum*(v: DVector64): DVector64 =
  result = newSeq[float64](v.len)
  cumulate(v, result, v.len)