Validating RDF data cube use NoSPA-RDF-Data-Cube-Validator
==========================================================

The NoSPA-RDF-Data-Cube-Validator is a standalone java implementation avialable at (<https://github.com/yyz1989/NoSPA-RDF-Data-Cube-Validator>). The jar file is available from (<https://github.com/yyz1989/NoSPA-RDF-Data-Cube-Validator/releases>).

The code below assumes the jar file is available at `/opt/NoSPA-RDF-Data-Cube-Validator-jar`.

The cd below in each code block is included because I could not find a quick way to get the code chunk executed in that directory. knitr is flexible enough to do it, I have not yet found the right way to do it. So, ignore the repeated cd ..

Integrity contstraints check on DC-DM-sample.ttl
------------------------------------------------

``` bash
cd ../extdata/sample-rdf
java -jar /opt/NoSPA-RDF-Data-Cube-Validator-jar/nospa-rdf-data-cube-validator-0.9.9-jar-with-dependencies.jar DC-DM-sample.ttl nospa
```

    ## ===NoSPA RDF Data Cube Validator===
    ## 2016-06-29 22:18:55,515 INFO - Loading cube file ...
    ## 2016-06-29 22:18:55,844 INFO - Normalizing cube at phase 1 ...
    ## 2016-06-29 22:18:55,850 INFO - Normalizing cube at phase 2 ...
    ## 2016-06-29 22:18:55,853 INFO - Validating all constraints ...
    ## 2016-06-29 22:18:55,853 INFO - Validating Integrity Constraint 1: Unique DataSet
    ## 2016-06-29 22:18:55,857 INFO - Validating Integrity Constraint 2: Unique DSD
    ## 2016-06-29 22:18:55,857 INFO - Validating Integrity Constraint 3: DSD Includes Measure
    ## 2016-06-29 22:18:55,858 INFO - Validating Integrity Constraint 4: Dimensions Have Range
    ## 2016-06-29 22:18:55,859 INFO - Validating Integrity Constraint 5: Concept Dimensions Have Code Lists
    ## 2016-06-29 22:18:55,860 INFO - Validating Integrity Constraint 6: Only Attributes May Be Optional
    ## 2016-06-29 22:18:55,861 INFO - Validating Integrity Constraint 7: Slice Keys Must Be Declared
    ## 2016-06-29 22:18:55,861 INFO - Validating Integrity Constraint 8: Slice Keys Consistent With DSD
    ## 2016-06-29 22:18:55,862 INFO - Validating Integrity Constraint 9: Unique Slice Structure
    ## 2016-06-29 22:18:55,863 INFO - Validating Integrity Constraint 10: Slice Dimensions Complete
    ## 2016-06-29 22:18:55,863 INFO - Validating Integrity Constraint 11: All Dimensions Required & Integrity Constraint 12: No Duplicate Observations
    ## 2016-06-29 22:18:55,865 INFO -     Validating dataset http://www.example.org/dc/dm/ds/dataset-DM
    ##     Validating observation 1 of 68
        Validating observation 2 of 68
        Validating observation 3 of 68
        Validating observation 4 of 68
        Validating observation 5 of 68
        Validating observation 6 of 68
        Validating observation 7 of 68
        Validating observation 8 of 68
        Validating observation 9 of 68
        Validating observation 10 of 68
        Validating observation 11 of 68
        Validating observation 12 of 68
        Validating observation 13 of 68
        Validating observation 14 of 68
        Validating observation 15 of 68
        Validating observation 16 of 68
        Validating observation 17 of 68
        Validating observation 18 of 68
        Validating observation 19 of 68
        Validating observation 20 of 68
        Validating observation 21 of 68
        Validating observation 22 of 68
        Validating observation 23 of 68
        Validating observation 24 of 68
        Validating observation 25 of 68
        Validating observation 26 of 68
        Validating observation 27 of 68
        Validating observation 28 of 68
        Validating observation 29 of 68
        Validating observation 30 of 68
        Validating observation 31 of 68
        Validating observation 32 of 68
        Validating observation 33 of 68
        Validating observation 34 of 68
        Validating observation 35 of 68
        Validating observation 36 of 68
        Validating observation 37 of 68
        Validating observation 38 of 68
        Validating observation 39 of 68
        Validating observation 40 of 68
        Validating observation 41 of 68
        Validating observation 42 of 68
        Validating observation 43 of 68
        Validating observation 44 of 68
        Validating observation 45 of 68
        Validating observation 46 of 68
        Validating observation 47 of 68
        Validating observation 48 of 68
        Validating observation 49 of 68
        Validating observation 50 of 68
        Validating observation 51 of 68
        Validating observation 52 of 68
        Validating observation 53 of 68
        Validating observation 54 of 68
        Validating observation 55 of 68
        Validating observation 56 of 68
        Validating observation 57 of 68
        Validating observation 58 of 68
        Validating observation 59 of 68
        Validating observation 60 of 68
        Validating observation 61 of 68
        Validating observation 62 of 68
        Validating observation 63 of 68
        Validating observation 64 of 68
        Validating observation 65 of 68
        Validating observation 66 of 68
        Validating observation 67 of 68
        Validating observation 68 of 68
    2016-06-29 22:18:55,875 INFO - Validating Integrity Constraint 13: Required Attributes
    ## 2016-06-29 22:18:55,876 INFO - Validating Integrity Constraint 14: All Measures Present
    ## 2016-06-29 22:18:55,878 INFO - Validating Integrity Constraint 15: Measure Dimension Consistent & Integrity Constraint 16: Single Measure On Measure Dimension Observation
    ## 2016-06-29 22:18:55,879 INFO - Validating Integrity Constraint 17: All Measures Present In Measures Dimension Cube
    ## 2016-06-29 22:18:55,881 INFO - Validating Integrity Constraint 18: Consistent Dataset Links
    ## 2016-06-29 22:18:55,881 INFO - Validating Integrity Constraint 19: Codes From Code List
    ## 2016-06-29 22:18:55,892 INFO - Validating Integrity Constraint 20: Codes From Hierarchy & Integrity Constraint 21: Codes From Hierarchy (Inverse)
    ## 2016-06-29 22:18:55,894 INFO - The validation task completed in 384ms

Integrity contstraints check on DC-AE-sample.ttl
------------------------------------------------

``` bash
cd ../extdata/sample-rdf
java -jar /opt/NoSPA-RDF-Data-Cube-Validator-jar/nospa-rdf-data-cube-validator-0.9.9-jar-with-dependencies.jar DC-AE-sample.ttl nospa
```

    ## ===NoSPA RDF Data Cube Validator===
    ## 2016-06-29 22:18:56,192 INFO - Loading cube file ...
    ## 2016-06-29 22:18:56,895 INFO - Normalizing cube at phase 1 ...
    ## 2016-06-29 22:18:56,911 INFO - Normalizing cube at phase 2 ...
    ## 2016-06-29 22:18:56,920 INFO - Validating all constraints ...
    ## 2016-06-29 22:18:56,920 INFO - Validating Integrity Constraint 1: Unique DataSet
    ## 2016-06-29 22:18:56,944 INFO - Validating Integrity Constraint 2: Unique DSD
    ## 2016-06-29 22:18:56,945 INFO - Validating Integrity Constraint 3: DSD Includes Measure
    ## 2016-06-29 22:18:56,946 INFO - Validating Integrity Constraint 4: Dimensions Have Range
    ## 2016-06-29 22:18:56,947 INFO - Validating Integrity Constraint 5: Concept Dimensions Have Code Lists
    ## 2016-06-29 22:18:56,948 INFO - Validating Integrity Constraint 6: Only Attributes May Be Optional
    ## 2016-06-29 22:18:56,949 INFO - Validating Integrity Constraint 7: Slice Keys Must Be Declared
    ## 2016-06-29 22:18:56,949 INFO - Validating Integrity Constraint 8: Slice Keys Consistent With DSD
    ## 2016-06-29 22:18:56,950 INFO - Validating Integrity Constraint 9: Unique Slice Structure
    ## 2016-06-29 22:18:56,951 INFO - Validating Integrity Constraint 10: Slice Dimensions Complete
    ## 2016-06-29 22:18:56,951 INFO - Validating Integrity Constraint 11: All Dimensions Required & Integrity Constraint 12: No Duplicate Observations
    ## 2016-06-29 22:18:56,954 INFO -     Validating dataset http://www.example.org/dc/ae/ds/dataset-AE
    ##     Validating observation 1 of 1406
        Validating observation 2 of 1406
        Validating observation 3 of 1406
        Validating observation 4 of 1406
        Validating observation 5 of 1406
        Validating observation 6 of 1406
        Validating observation 7 of 1406
        Validating observation 8 of 1406
        Validating observation 9 of 1406
        Validating observation 10 of 1406
        Validating observation 11 of 1406
        Validating observation 12 of 1406
        Validating observation 13 of 1406
        Validating observation 14 of 1406
        Validating observation 15 of 1406
        Validating observation 16 of 1406
        Validating observation 17 of 1406
        Validating observation 18 of 1406
        Validating observation 19 of 1406
        Validating observation 20 of 1406
        Validating observation 21 of 1406
        Validating observation 22 of 1406
        Validating observation 23 of 1406
        Validating observation 24 of 1406
        Validating observation 25 of 1406
        Validating observation 26 of 1406
        Validating observation 27 of 1406
        Validating observation 28 of 1406
        Validating observation 29 of 1406
        Validating observation 30 of 1406
        Validating observation 31 of 1406
        Validating observation 32 of 1406
        Validating observation 33 of 1406
        Validating observation 34 of 1406
        Validating observation 35 of 1406
        Validating observation 36 of 1406
        Validating observation 37 of 1406
        Validating observation 38 of 1406
        Validating observation 39 of 1406
        Validating observation 40 of 1406
        Validating observation 41 of 1406
        Validating observation 42 of 1406
        Validating observation 43 of 1406
        Validating observation 44 of 1406
        Validating observation 45 of 1406
        Validating observation 46 of 1406
        Validating observation 47 of 1406
        Validating observation 48 of 1406
        Validating observation 49 of 1406
        Validating observation 50 of 1406
        Validating observation 51 of 1406
        Validating observation 52 of 1406
        Validating observation 53 of 1406
        Validating observation 54 of 1406
        Validating observation 55 of 1406
        Validating observation 56 of 1406
        Validating observation 57 of 1406
        Validating observation 58 of 1406
        Validating observation 59 of 1406
        Validating observation 60 of 1406
        Validating observation 61 of 1406
        Validating observation 62 of 1406
        Validating observation 63 of 1406
        Validating observation 64 of 1406
        Validating observation 65 of 1406
        Validating observation 66 of 1406
        Validating observation 67 of 1406
        Validating observation 68 of 1406
        Validating observation 69 of 1406
        Validating observation 70 of 1406
        Validating observation 71 of 1406
        Validating observation 72 of 1406
        Validating observation 73 of 1406
        Validating observation 74 of 1406
        Validating observation 75 of 1406
        Validating observation 76 of 1406
        Validating observation 77 of 1406
        Validating observation 78 of 1406
        Validating observation 79 of 1406
        Validating observation 80 of 1406
        Validating observation 81 of 1406
        Validating observation 82 of 1406
        Validating observation 83 of 1406
        Validating observation 84 of 1406
        Validating observation 85 of 1406
        Validating observation 86 of 1406
        Validating observation 87 of 1406
        Validating observation 88 of 1406
        Validating observation 89 of 1406
        Validating observation 90 of 1406
        Validating observation 91 of 1406
        Validating observation 92 of 1406
        Validating observation 93 of 1406
        Validating observation 94 of 1406
        Validating observation 95 of 1406
        Validating observation 96 of 1406
        Validating observation 97 of 1406
        Validating observation 98 of 1406
        Validating observation 99 of 1406
        Validating observation 100 of 1406
        Validating observation 101 of 1406
        Validating observation 102 of 1406
        Validating observation 103 of 1406
        Validating observation 104 of 1406
        Validating observation 105 of 1406
        Validating observation 106 of 1406
        Validating observation 107 of 1406
        Validating observation 108 of 1406
        Validating observation 109 of 1406
        Validating observation 110 of 1406
        Validating observation 111 of 1406
        Validating observation 112 of 1406
        Validating observation 113 of 1406
        Validating observation 114 of 1406
        Validating observation 115 of 1406
        Validating observation 116 of 1406
        Validating observation 117 of 1406
        Validating observation 118 of 1406
        Validating observation 119 of 1406
        Validating observation 120 of 1406
        Validating observation 121 of 1406
        Validating observation 122 of 1406
        Validating observation 123 of 1406
        Validating observation 124 of 1406
        Validating observation 125 of 1406
        Validating observation 126 of 1406
        Validating observation 127 of 1406
        Validating observation 128 of 1406
        Validating observation 129 of 1406
        Validating observation 130 of 1406
        Validating observation 131 of 1406
        Validating observation 132 of 1406
        Validating observation 133 of 1406
        Validating observation 134 of 1406
        Validating observation 135 of 1406
        Validating observation 136 of 1406
        Validating observation 137 of 1406
        Validating observation 138 of 1406
        Validating observation 139 of 1406
        Validating observation 140 of 1406
        Validating observation 141 of 1406
        Validating observation 142 of 1406
        Validating observation 143 of 1406
        Validating observation 144 of 1406
        Validating observation 145 of 1406
        Validating observation 146 of 1406
        Validating observation 147 of 1406
        Validating observation 148 of 1406
        Validating observation 149 of 1406
        Validating observation 150 of 1406
        Validating observation 151 of 1406
        Validating observation 152 of 1406
        Validating observation 153 of 1406
        Validating observation 154 of 1406
        Validating observation 155 of 1406
        Validating observation 156 of 1406
        Validating observation 157 of 1406
        Validating observation 158 of 1406
        Validating observation 159 of 1406
        Validating observation 160 of 1406
        Validating observation 161 of 1406
        Validating observation 162 of 1406
        Validating observation 163 of 1406
        Validating observation 164 of 1406
        Validating observation 165 of 1406
        Validating observation 166 of 1406
        Validating observation 167 of 1406
        Validating observation 168 of 1406
        Validating observation 169 of 1406
        Validating observation 170 of 1406
        Validating observation 171 of 1406
        Validating observation 172 of 1406
        Validating observation 173 of 1406
        Validating observation 174 of 1406
        Validating observation 175 of 1406
        Validating observation 176 of 1406
        Validating observation 177 of 1406
        Validating observation 178 of 1406
        Validating observation 179 of 1406
        Validating observation 180 of 1406
        Validating observation 181 of 1406
        Validating observation 182 of 1406
        Validating observation 183 of 1406
        Validating observation 184 of 1406
        Validating observation 185 of 1406
        Validating observation 186 of 1406
        Validating observation 187 of 1406
        Validating observation 188 of 1406
        Validating observation 189 of 1406
        Validating observation 190 of 1406
        Validating observation 191 of 1406
        Validating observation 192 of 1406
        Validating observation 193 of 1406
        Validating observation 194 of 1406
        Validating observation 195 of 1406
        Validating observation 196 of 1406
        Validating observation 197 of 1406
        Validating observation 198 of 1406
        Validating observation 199 of 1406
        Validating observation 200 of 1406
        Validating observation 201 of 1406
        Validating observation 202 of 1406
        Validating observation 203 of 1406
        Validating observation 204 of 1406
        Validating observation 205 of 1406
        Validating observation 206 of 1406
        Validating observation 207 of 1406
        Validating observation 208 of 1406
        Validating observation 209 of 1406
        Validating observation 210 of 1406
        Validating observation 211 of 1406
        Validating observation 212 of 1406
        Validating observation 213 of 1406
        Validating observation 214 of 1406
        Validating observation 215 of 1406
        Validating observation 216 of 1406
        Validating observation 217 of 1406
        Validating observation 218 of 1406
        Validating observation 219 of 1406
        Validating observation 220 of 1406
        Validating observation 221 of 1406
        Validating observation 222 of 1406
        Validating observation 223 of 1406
        Validating observation 224 of 1406
        Validating observation 225 of 1406
        Validating observation 226 of 1406
        Validating observation 227 of 1406
        Validating observation 228 of 1406
        Validating observation 229 of 1406
        Validating observation 230 of 1406
        Validating observation 231 of 1406
        Validating observation 232 of 1406
        Validating observation 233 of 1406
        Validating observation 234 of 1406
        Validating observation 235 of 1406
        Validating observation 236 of 1406
        Validating observation 237 of 1406
        Validating observation 238 of 1406
        Validating observation 239 of 1406
        Validating observation 240 of 1406
        Validating observation 241 of 1406
        Validating observation 242 of 1406
        Validating observation 243 of 1406
        Validating observation 244 of 1406
        Validating observation 245 of 1406
        Validating observation 246 of 1406
        Validating observation 247 of 1406
        Validating observation 248 of 1406
        Validating observation 249 of 1406
        Validating observation 250 of 1406
        Validating observation 251 of 1406
        Validating observation 252 of 1406
        Validating observation 253 of 1406
        Validating observation 254 of 1406
        Validating observation 255 of 1406
        Validating observation 256 of 1406
        Validating observation 257 of 1406
        Validating observation 258 of 1406
        Validating observation 259 of 1406
        Validating observation 260 of 1406
        Validating observation 261 of 1406
        Validating observation 262 of 1406
        Validating observation 263 of 1406
        Validating observation 264 of 1406
        Validating observation 265 of 1406
        Validating observation 266 of 1406
        Validating observation 267 of 1406
        Validating observation 268 of 1406
        Validating observation 269 of 1406
        Validating observation 270 of 1406
        Validating observation 271 of 1406
        Validating observation 272 of 1406
        Validating observation 273 of 1406
        Validating observation 274 of 1406
        Validating observation 275 of 1406
        Validating observation 276 of 1406
        Validating observation 277 of 1406
        Validating observation 278 of 1406
        Validating observation 279 of 1406
        Validating observation 280 of 1406
        Validating observation 281 of 1406
        Validating observation 282 of 1406
        Validating observation 283 of 1406
        Validating observation 284 of 1406
        Validating observation 285 of 1406
        Validating observation 286 of 1406
        Validating observation 287 of 1406
        Validating observation 288 of 1406
        Validating observation 289 of 1406
        Validating observation 290 of 1406
        Validating observation 291 of 1406
        Validating observation 292 of 1406
        Validating observation 293 of 1406
        Validating observation 294 of 1406
        Validating observation 295 of 1406
        Validating observation 296 of 1406
        Validating observation 297 of 1406
        Validating observation 298 of 1406
        Validating observation 299 of 1406
        Validating observation 300 of 1406
        Validating observation 301 of 1406
        Validating observation 302 of 1406
        Validating observation 303 of 1406
        Validating observation 304 of 1406
        Validating observation 305 of 1406
        Validating observation 306 of 1406
        Validating observation 307 of 1406
        Validating observation 308 of 1406
        Validating observation 309 of 1406
        Validating observation 310 of 1406
        Validating observation 311 of 1406
        Validating observation 312 of 1406
        Validating observation 313 of 1406
        Validating observation 314 of 1406
        Validating observation 315 of 1406
        Validating observation 316 of 1406
        Validating observation 317 of 1406
        Validating observation 318 of 1406
        Validating observation 319 of 1406
        Validating observation 320 of 1406
        Validating observation 321 of 1406
        Validating observation 322 of 1406
        Validating observation 323 of 1406
        Validating observation 324 of 1406
        Validating observation 325 of 1406
        Validating observation 326 of 1406
        Validating observation 327 of 1406
        Validating observation 328 of 1406
        Validating observation 329 of 1406
        Validating observation 330 of 1406
        Validating observation 331 of 1406
        Validating observation 332 of 1406
        Validating observation 333 of 1406
        Validating observation 334 of 1406
        Validating observation 335 of 1406
        Validating observation 336 of 1406
        Validating observation 337 of 1406
        Validating observation 338 of 1406
        Validating observation 339 of 1406
        Validating observation 340 of 1406
        Validating observation 341 of 1406
        Validating observation 342 of 1406
        Validating observation 343 of 1406
        Validating observation 344 of 1406
        Validating observation 345 of 1406
        Validating observation 346 of 1406
        Validating observation 347 of 1406
        Validating observation 348 of 1406
        Validating observation 349 of 1406
        Validating observation 350 of 1406
        Validating observation 351 of 1406
        Validating observation 352 of 1406
        Validating observation 353 of 1406
        Validating observation 354 of 1406
        Validating observation 355 of 1406
        Validating observation 356 of 1406
        Validating observation 357 of 1406
        Validating observation 358 of 1406
        Validating observation 359 of 1406
        Validating observation 360 of 1406
        Validating observation 361 of 1406
        Validating observation 362 of 1406
        Validating observation 363 of 1406
        Validating observation 364 of 1406
        Validating observation 365 of 1406
        Validating observation 366 of 1406
        Validating observation 367 of 1406
        Validating observation 368 of 1406
        Validating observation 369 of 1406
        Validating observation 370 of 1406
        Validating observation 371 of 1406
        Validating observation 372 of 1406
        Validating observation 373 of 1406
        Validating observation 374 of 1406
        Validating observation 375 of 1406
        Validating observation 376 of 1406
        Validating observation 377 of 1406
        Validating observation 378 of 1406
        Validating observation 379 of 1406
        Validating observation 380 of 1406
        Validating observation 381 of 1406
        Validating observation 382 of 1406
        Validating observation 383 of 1406
        Validating observation 384 of 1406
        Validating observation 385 of 1406
        Validating observation 386 of 1406
        Validating observation 387 of 1406
        Validating observation 388 of 1406
        Validating observation 389 of 1406
        Validating observation 390 of 1406
        Validating observation 391 of 1406
        Validating observation 392 of 1406
        Validating observation 393 of 1406
        Validating observation 394 of 1406
        Validating observation 395 of 1406
        Validating observation 396 of 1406
        Validating observation 397 of 1406
        Validating observation 398 of 1406
        Validating observation 399 of 1406
        Validating observation 400 of 1406
        Validating observation 401 of 1406
        Validating observation 402 of 1406
        Validating observation 403 of 1406
        Validating observation 404 of 1406
        Validating observation 405 of 1406
        Validating observation 406 of 1406
        Validating observation 407 of 1406
        Validating observation 408 of 1406
        Validating observation 409 of 1406
        Validating observation 410 of 1406
        Validating observation 411 of 1406
        Validating observation 412 of 1406
        Validating observation 413 of 1406
        Validating observation 414 of 1406
        Validating observation 415 of 1406
        Validating observation 416 of 1406
        Validating observation 417 of 1406
        Validating observation 418 of 1406
        Validating observation 419 of 1406
        Validating observation 420 of 1406
        Validating observation 421 of 1406
        Validating observation 422 of 1406
        Validating observation 423 of 1406
        Validating observation 424 of 1406
        Validating observation 425 of 1406
        Validating observation 426 of 1406
        Validating observation 427 of 1406
        Validating observation 428 of 1406
        Validating observation 429 of 1406
        Validating observation 430 of 1406
        Validating observation 431 of 1406
        Validating observation 432 of 1406
        Validating observation 433 of 1406
        Validating observation 434 of 1406
        Validating observation 435 of 1406
        Validating observation 436 of 1406
        Validating observation 437 of 1406
        Validating observation 438 of 1406
        Validating observation 439 of 1406
        Validating observation 440 of 1406
        Validating observation 441 of 1406
        Validating observation 442 of 1406
        Validating observation 443 of 1406
        Validating observation 444 of 1406
        Validating observation 445 of 1406
        Validating observation 446 of 1406
        Validating observation 447 of 1406
        Validating observation 448 of 1406
        Validating observation 449 of 1406
        Validating observation 450 of 1406
        Validating observation 451 of 1406
        Validating observation 452 of 1406
        Validating observation 453 of 1406
        Validating observation 454 of 1406
        Validating observation 455 of 1406
        Validating observation 456 of 1406
        Validating observation 457 of 1406
        Validating observation 458 of 1406
        Validating observation 459 of 1406
        Validating observation 460 of 1406
        Validating observation 461 of 1406
        Validating observation 462 of 1406
        Validating observation 463 of 1406
        Validating observation 464 of 1406
        Validating observation 465 of 1406
        Validating observation 466 of 1406
        Validating observation 467 of 1406
        Validating observation 468 of 1406
        Validating observation 469 of 1406
        Validating observation 470 of 1406
        Validating observation 471 of 1406
        Validating observation 472 of 1406
        Validating observation 473 of 1406
        Validating observation 474 of 1406
        Validating observation 475 of 1406
        Validating observation 476 of 1406
        Validating observation 477 of 1406
        Validating observation 478 of 1406
        Validating observation 479 of 1406
        Validating observation 480 of 1406
        Validating observation 481 of 1406
        Validating observation 482 of 1406
        Validating observation 483 of 1406
        Validating observation 484 of 1406
        Validating observation 485 of 1406
        Validating observation 486 of 1406
        Validating observation 487 of 1406
        Validating observation 488 of 1406
        Validating observation 489 of 1406
        Validating observation 490 of 1406
        Validating observation 491 of 1406
        Validating observation 492 of 1406
        Validating observation 493 of 1406
        Validating observation 494 of 1406
        Validating observation 495 of 1406
        Validating observation 496 of 1406
        Validating observation 497 of 1406
        Validating observation 498 of 1406
        Validating observation 499 of 1406
        Validating observation 500 of 1406
        Validating observation 501 of 1406
        Validating observation 502 of 1406
        Validating observation 503 of 1406
        Validating observation 504 of 1406
        Validating observation 505 of 1406
        Validating observation 506 of 1406
        Validating observation 507 of 1406
        Validating observation 508 of 1406
        Validating observation 509 of 1406
        Validating observation 510 of 1406
        Validating observation 511 of 1406
        Validating observation 512 of 1406
        Validating observation 513 of 1406
        Validating observation 514 of 1406
        Validating observation 515 of 1406
        Validating observation 516 of 1406
        Validating observation 517 of 1406
        Validating observation 518 of 1406
        Validating observation 519 of 1406
        Validating observation 520 of 1406
        Validating observation 521 of 1406
        Validating observation 522 of 1406
        Validating observation 523 of 1406
        Validating observation 524 of 1406
        Validating observation 525 of 1406
        Validating observation 526 of 1406
        Validating observation 527 of 1406
        Validating observation 528 of 1406
        Validating observation 529 of 1406
        Validating observation 530 of 1406
        Validating observation 531 of 1406
        Validating observation 532 of 1406
        Validating observation 533 of 1406
        Validating observation 534 of 1406
        Validating observation 535 of 1406
        Validating observation 536 of 1406
        Validating observation 537 of 1406
        Validating observation 538 of 1406
        Validating observation 539 of 1406
        Validating observation 540 of 1406
        Validating observation 541 of 1406
        Validating observation 542 of 1406
        Validating observation 543 of 1406
        Validating observation 544 of 1406
        Validating observation 545 of 1406
        Validating observation 546 of 1406
        Validating observation 547 of 1406
        Validating observation 548 of 1406
        Validating observation 549 of 1406
        Validating observation 550 of 1406
        Validating observation 551 of 1406
        Validating observation 552 of 1406
        Validating observation 553 of 1406
        Validating observation 554 of 1406
        Validating observation 555 of 1406
        Validating observation 556 of 1406
        Validating observation 557 of 1406
        Validating observation 558 of 1406
        Validating observation 559 of 1406
        Validating observation 560 of 1406
        Validating observation 561 of 1406
        Validating observation 562 of 1406
        Validating observation 563 of 1406
        Validating observation 564 of 1406
        Validating observation 565 of 1406
        Validating observation 566 of 1406
        Validating observation 567 of 1406
        Validating observation 568 of 1406
        Validating observation 569 of 1406
        Validating observation 570 of 1406
        Validating observation 571 of 1406
        Validating observation 572 of 1406
        Validating observation 573 of 1406
        Validating observation 574 of 1406
        Validating observation 575 of 1406
        Validating observation 576 of 1406
        Validating observation 577 of 1406
        Validating observation 578 of 1406
        Validating observation 579 of 1406
        Validating observation 580 of 1406
        Validating observation 581 of 1406
        Validating observation 582 of 1406
        Validating observation 583 of 1406
        Validating observation 584 of 1406
        Validating observation 585 of 1406
        Validating observation 586 of 1406
        Validating observation 587 of 1406
        Validating observation 588 of 1406
        Validating observation 589 of 1406
        Validating observation 590 of 1406
        Validating observation 591 of 1406
        Validating observation 592 of 1406
        Validating observation 593 of 1406
        Validating observation 594 of 1406
        Validating observation 595 of 1406
        Validating observation 596 of 1406
        Validating observation 597 of 1406
        Validating observation 598 of 1406
        Validating observation 599 of 1406
        Validating observation 600 of 1406
        Validating observation 601 of 1406
        Validating observation 602 of 1406
        Validating observation 603 of 1406
        Validating observation 604 of 1406
        Validating observation 605 of 1406
        Validating observation 606 of 1406
        Validating observation 607 of 1406
        Validating observation 608 of 1406
        Validating observation 609 of 1406
        Validating observation 610 of 1406
        Validating observation 611 of 1406
        Validating observation 612 of 1406
        Validating observation 613 of 1406
        Validating observation 614 of 1406
        Validating observation 615 of 1406
        Validating observation 616 of 1406
        Validating observation 617 of 1406
        Validating observation 618 of 1406
        Validating observation 619 of 1406
        Validating observation 620 of 1406
        Validating observation 621 of 1406
        Validating observation 622 of 1406
        Validating observation 623 of 1406
        Validating observation 624 of 1406
        Validating observation 625 of 1406
        Validating observation 626 of 1406
        Validating observation 627 of 1406
        Validating observation 628 of 1406
        Validating observation 629 of 1406
        Validating observation 630 of 1406
        Validating observation 631 of 1406
        Validating observation 632 of 1406
        Validating observation 633 of 1406
        Validating observation 634 of 1406
        Validating observation 635 of 1406
        Validating observation 636 of 1406
        Validating observation 637 of 1406
        Validating observation 638 of 1406
        Validating observation 639 of 1406
        Validating observation 640 of 1406
        Validating observation 641 of 1406
        Validating observation 642 of 1406
        Validating observation 643 of 1406
        Validating observation 644 of 1406
        Validating observation 645 of 1406
        Validating observation 646 of 1406
        Validating observation 647 of 1406
        Validating observation 648 of 1406
        Validating observation 649 of 1406
        Validating observation 650 of 1406
        Validating observation 651 of 1406
        Validating observation 652 of 1406
        Validating observation 653 of 1406
        Validating observation 654 of 1406
        Validating observation 655 of 1406
        Validating observation 656 of 1406
        Validating observation 657 of 1406
        Validating observation 658 of 1406
        Validating observation 659 of 1406
        Validating observation 660 of 1406
        Validating observation 661 of 1406
        Validating observation 662 of 1406
        Validating observation 663 of 1406
        Validating observation 664 of 1406
        Validating observation 665 of 1406
        Validating observation 666 of 1406
        Validating observation 667 of 1406
        Validating observation 668 of 1406
        Validating observation 669 of 1406
        Validating observation 670 of 1406
        Validating observation 671 of 1406
        Validating observation 672 of 1406
        Validating observation 673 of 1406
        Validating observation 674 of 1406
        Validating observation 675 of 1406
        Validating observation 676 of 1406
        Validating observation 677 of 1406
        Validating observation 678 of 1406
        Validating observation 679 of 1406
        Validating observation 680 of 1406
        Validating observation 681 of 1406
        Validating observation 682 of 1406
        Validating observation 683 of 1406
        Validating observation 684 of 1406
        Validating observation 685 of 1406
        Validating observation 686 of 1406
        Validating observation 687 of 1406
        Validating observation 688 of 1406
        Validating observation 689 of 1406
        Validating observation 690 of 1406
        Validating observation 691 of 1406
        Validating observation 692 of 1406
        Validating observation 693 of 1406
        Validating observation 694 of 1406
        Validating observation 695 of 1406
        Validating observation 696 of 1406
        Validating observation 697 of 1406
        Validating observation 698 of 1406
        Validating observation 699 of 1406
        Validating observation 700 of 1406
        Validating observation 701 of 1406
        Validating observation 702 of 1406
        Validating observation 703 of 1406
        Validating observation 704 of 1406
        Validating observation 705 of 1406
        Validating observation 706 of 1406
        Validating observation 707 of 1406
        Validating observation 708 of 1406
        Validating observation 709 of 1406
        Validating observation 710 of 1406
        Validating observation 711 of 1406
        Validating observation 712 of 1406
        Validating observation 713 of 1406
        Validating observation 714 of 1406
        Validating observation 715 of 1406
        Validating observation 716 of 1406
        Validating observation 717 of 1406
        Validating observation 718 of 1406
        Validating observation 719 of 1406
        Validating observation 720 of 1406
        Validating observation 721 of 1406
        Validating observation 722 of 1406
        Validating observation 723 of 1406
        Validating observation 724 of 1406
        Validating observation 725 of 1406
        Validating observation 726 of 1406
        Validating observation 727 of 1406
        Validating observation 728 of 1406
        Validating observation 729 of 1406
        Validating observation 730 of 1406
        Validating observation 731 of 1406
        Validating observation 732 of 1406
        Validating observation 733 of 1406
        Validating observation 734 of 1406
        Validating observation 735 of 1406
        Validating observation 736 of 1406
        Validating observation 737 of 1406
        Validating observation 738 of 1406
        Validating observation 739 of 1406
        Validating observation 740 of 1406
        Validating observation 741 of 1406
        Validating observation 742 of 1406
        Validating observation 743 of 1406
        Validating observation 744 of 1406
        Validating observation 745 of 1406
        Validating observation 746 of 1406
        Validating observation 747 of 1406
        Validating observation 748 of 1406
        Validating observation 749 of 1406
        Validating observation 750 of 1406
        Validating observation 751 of 1406
        Validating observation 752 of 1406
        Validating observation 753 of 1406
        Validating observation 754 of 1406
        Validating observation 755 of 1406
        Validating observation 756 of 1406
        Validating observation 757 of 1406
        Validating observation 758 of 1406
        Validating observation 759 of 1406
        Validating observation 760 of 1406
        Validating observation 761 of 1406
        Validating observation 762 of 1406
        Validating observation 763 of 1406
        Validating observation 764 of 1406
        Validating observation 765 of 1406
        Validating observation 766 of 1406
        Validating observation 767 of 1406
        Validating observation 768 of 1406
        Validating observation 769 of 1406
        Validating observation 770 of 1406
        Validating observation 771 of 1406
        Validating observation 772 of 1406
        Validating observation 773 of 1406
        Validating observation 774 of 1406
        Validating observation 775 of 1406
        Validating observation 776 of 1406
        Validating observation 777 of 1406
        Validating observation 778 of 1406
        Validating observation 779 of 1406
        Validating observation 780 of 1406
        Validating observation 781 of 1406
        Validating observation 782 of 1406
        Validating observation 783 of 1406
        Validating observation 784 of 1406
        Validating observation 785 of 1406
        Validating observation 786 of 1406
        Validating observation 787 of 1406
        Validating observation 788 of 1406
        Validating observation 789 of 1406
        Validating observation 790 of 1406
        Validating observation 791 of 1406
        Validating observation 792 of 1406
        Validating observation 793 of 1406
        Validating observation 794 of 1406
        Validating observation 795 of 1406
        Validating observation 796 of 1406
        Validating observation 797 of 1406
        Validating observation 798 of 1406
        Validating observation 799 of 1406
        Validating observation 800 of 1406
        Validating observation 801 of 1406
        Validating observation 802 of 1406
        Validating observation 803 of 1406
        Validating observation 804 of 1406
        Validating observation 805 of 1406
        Validating observation 806 of 1406
        Validating observation 807 of 1406
        Validating observation 808 of 1406
        Validating observation 809 of 1406
        Validating observation 810 of 1406
        Validating observation 811 of 1406
        Validating observation 812 of 1406
        Validating observation 813 of 1406
        Validating observation 814 of 1406
        Validating observation 815 of 1406
        Validating observation 816 of 1406
        Validating observation 817 of 1406
        Validating observation 818 of 1406
        Validating observation 819 of 1406
        Validating observation 820 of 1406
        Validating observation 821 of 1406
        Validating observation 822 of 1406
        Validating observation 823 of 1406
        Validating observation 824 of 1406
        Validating observation 825 of 1406
        Validating observation 826 of 1406
        Validating observation 827 of 1406
        Validating observation 828 of 1406
        Validating observation 829 of 1406
        Validating observation 830 of 1406
        Validating observation 831 of 1406
        Validating observation 832 of 1406
        Validating observation 833 of 1406
        Validating observation 834 of 1406
        Validating observation 835 of 1406
        Validating observation 836 of 1406
        Validating observation 837 of 1406
        Validating observation 838 of 1406
        Validating observation 839 of 1406
        Validating observation 840 of 1406
        Validating observation 841 of 1406
        Validating observation 842 of 1406
        Validating observation 843 of 1406
        Validating observation 844 of 1406
        Validating observation 845 of 1406
        Validating observation 846 of 1406
        Validating observation 847 of 1406
        Validating observation 848 of 1406
        Validating observation 849 of 1406
        Validating observation 850 of 1406
        Validating observation 851 of 1406
        Validating observation 852 of 1406
        Validating observation 853 of 1406
        Validating observation 854 of 1406
        Validating observation 855 of 1406
        Validating observation 856 of 1406
        Validating observation 857 of 1406
        Validating observation 858 of 1406
        Validating observation 859 of 1406
        Validating observation 860 of 1406
        Validating observation 861 of 1406
        Validating observation 862 of 1406
        Validating observation 863 of 1406
        Validating observation 864 of 1406
        Validating observation 865 of 1406
        Validating observation 866 of 1406
        Validating observation 867 of 1406
        Validating observation 868 of 1406
        Validating observation 869 of 1406
        Validating observation 870 of 1406
        Validating observation 871 of 1406
        Validating observation 872 of 1406
        Validating observation 873 of 1406
        Validating observation 874 of 1406
        Validating observation 875 of 1406
        Validating observation 876 of 1406
        Validating observation 877 of 1406
        Validating observation 878 of 1406
        Validating observation 879 of 1406
        Validating observation 880 of 1406
        Validating observation 881 of 1406
        Validating observation 882 of 1406
        Validating observation 883 of 1406
        Validating observation 884 of 1406
        Validating observation 885 of 1406
        Validating observation 886 of 1406
        Validating observation 887 of 1406
        Validating observation 888 of 1406
        Validating observation 889 of 1406
        Validating observation 890 of 1406
        Validating observation 891 of 1406
        Validating observation 892 of 1406
        Validating observation 893 of 1406
        Validating observation 894 of 1406
        Validating observation 895 of 1406
        Validating observation 896 of 1406
        Validating observation 897 of 1406
        Validating observation 898 of 1406
        Validating observation 899 of 1406
        Validating observation 900 of 1406
        Validating observation 901 of 1406
        Validating observation 902 of 1406
        Validating observation 903 of 1406
        Validating observation 904 of 1406
        Validating observation 905 of 1406
        Validating observation 906 of 1406
        Validating observation 907 of 1406
        Validating observation 908 of 1406
        Validating observation 909 of 1406
        Validating observation 910 of 1406
        Validating observation 911 of 1406
        Validating observation 912 of 1406
        Validating observation 913 of 1406
        Validating observation 914 of 1406
        Validating observation 915 of 1406
        Validating observation 916 of 1406
        Validating observation 917 of 1406
        Validating observation 918 of 1406
        Validating observation 919 of 1406
        Validating observation 920 of 1406
        Validating observation 921 of 1406
        Validating observation 922 of 1406
        Validating observation 923 of 1406
        Validating observation 924 of 1406
        Validating observation 925 of 1406
        Validating observation 926 of 1406
        Validating observation 927 of 1406
        Validating observation 928 of 1406
        Validating observation 929 of 1406
        Validating observation 930 of 1406
        Validating observation 931 of 1406
        Validating observation 932 of 1406
        Validating observation 933 of 1406
        Validating observation 934 of 1406
        Validating observation 935 of 1406
        Validating observation 936 of 1406
        Validating observation 937 of 1406
        Validating observation 938 of 1406
        Validating observation 939 of 1406
        Validating observation 940 of 1406
        Validating observation 941 of 1406
        Validating observation 942 of 1406
        Validating observation 943 of 1406
        Validating observation 944 of 1406
        Validating observation 945 of 1406
        Validating observation 946 of 1406
        Validating observation 947 of 1406
        Validating observation 948 of 1406
        Validating observation 949 of 1406
        Validating observation 950 of 1406
        Validating observation 951 of 1406
        Validating observation 952 of 1406
        Validating observation 953 of 1406
        Validating observation 954 of 1406
        Validating observation 955 of 1406
        Validating observation 956 of 1406
        Validating observation 957 of 1406
        Validating observation 958 of 1406
        Validating observation 959 of 1406
        Validating observation 960 of 1406
        Validating observation 961 of 1406
        Validating observation 962 of 1406
        Validating observation 963 of 1406
        Validating observation 964 of 1406
        Validating observation 965 of 1406
        Validating observation 966 of 1406
        Validating observation 967 of 1406
        Validating observation 968 of 1406
        Validating observation 969 of 1406
        Validating observation 970 of 1406
        Validating observation 971 of 1406
        Validating observation 972 of 1406
        Validating observation 973 of 1406
        Validating observation 974 of 1406
        Validating observation 975 of 1406
        Validating observation 976 of 1406
        Validating observation 977 of 1406
        Validating observation 978 of 1406
        Validating observation 979 of 1406
        Validating observation 980 of 1406
        Validating observation 981 of 1406
        Validating observation 982 of 1406
        Validating observation 983 of 1406
        Validating observation 984 of 1406
        Validating observation 985 of 1406
        Validating observation 986 of 1406
        Validating observation 987 of 1406
        Validating observation 988 of 1406
        Validating observation 989 of 1406
        Validating observation 990 of 1406
        Validating observation 991 of 1406
        Validating observation 992 of 1406
        Validating observation 993 of 1406
        Validating observation 994 of 1406
        Validating observation 995 of 1406
        Validating observation 996 of 1406
        Validating observation 997 of 1406
        Validating observation 998 of 1406
        Validating observation 999 of 1406
        Validating observation 1000 of 1406
        Validating observation 1001 of 1406
        Validating observation 1002 of 1406
        Validating observation 1003 of 1406
        Validating observation 1004 of 1406
        Validating observation 1005 of 1406
        Validating observation 1006 of 1406
        Validating observation 1007 of 1406
        Validating observation 1008 of 1406
        Validating observation 1009 of 1406
        Validating observation 1010 of 1406
        Validating observation 1011 of 1406
        Validating observation 1012 of 1406
        Validating observation 1013 of 1406
        Validating observation 1014 of 1406
        Validating observation 1015 of 1406
        Validating observation 1016 of 1406
        Validating observation 1017 of 1406
        Validating observation 1018 of 1406
        Validating observation 1019 of 1406
        Validating observation 1020 of 1406
        Validating observation 1021 of 1406
        Validating observation 1022 of 1406
        Validating observation 1023 of 1406
        Validating observation 1024 of 1406
        Validating observation 1025 of 1406
        Validating observation 1026 of 1406
        Validating observation 1027 of 1406
        Validating observation 1028 of 1406
        Validating observation 1029 of 1406
        Validating observation 1030 of 1406
        Validating observation 1031 of 1406
        Validating observation 1032 of 1406
        Validating observation 1033 of 1406
        Validating observation 1034 of 1406
        Validating observation 1035 of 1406
        Validating observation 1036 of 1406
        Validating observation 1037 of 1406
        Validating observation 1038 of 1406
        Validating observation 1039 of 1406
        Validating observation 1040 of 1406
        Validating observation 1041 of 1406
        Validating observation 1042 of 1406
        Validating observation 1043 of 1406
        Validating observation 1044 of 1406
        Validating observation 1045 of 1406
        Validating observation 1046 of 1406
        Validating observation 1047 of 1406
        Validating observation 1048 of 1406
        Validating observation 1049 of 1406
        Validating observation 1050 of 1406
        Validating observation 1051 of 1406
        Validating observation 1052 of 1406
        Validating observation 1053 of 1406
        Validating observation 1054 of 1406
        Validating observation 1055 of 1406
        Validating observation 1056 of 1406
        Validating observation 1057 of 1406
        Validating observation 1058 of 1406
        Validating observation 1059 of 1406
        Validating observation 1060 of 1406
        Validating observation 1061 of 1406
        Validating observation 1062 of 1406
        Validating observation 1063 of 1406
        Validating observation 1064 of 1406
        Validating observation 1065 of 1406
        Validating observation 1066 of 1406
        Validating observation 1067 of 1406
        Validating observation 1068 of 1406
        Validating observation 1069 of 1406
        Validating observation 1070 of 1406
        Validating observation 1071 of 1406
        Validating observation 1072 of 1406
        Validating observation 1073 of 1406
        Validating observation 1074 of 1406
        Validating observation 1075 of 1406
        Validating observation 1076 of 1406
        Validating observation 1077 of 1406
        Validating observation 1078 of 1406
        Validating observation 1079 of 1406
        Validating observation 1080 of 1406
        Validating observation 1081 of 1406
        Validating observation 1082 of 1406
        Validating observation 1083 of 1406
        Validating observation 1084 of 1406
        Validating observation 1085 of 1406
        Validating observation 1086 of 1406
        Validating observation 1087 of 1406
        Validating observation 1088 of 1406
        Validating observation 1089 of 1406
        Validating observation 1090 of 1406
        Validating observation 1091 of 1406
        Validating observation 1092 of 1406
        Validating observation 1093 of 1406
        Validating observation 1094 of 1406
        Validating observation 1095 of 1406
        Validating observation 1096 of 1406
        Validating observation 1097 of 1406
        Validating observation 1098 of 1406
        Validating observation 1099 of 1406
        Validating observation 1100 of 1406
        Validating observation 1101 of 1406
        Validating observation 1102 of 1406
        Validating observation 1103 of 1406
        Validating observation 1104 of 1406
        Validating observation 1105 of 1406
        Validating observation 1106 of 1406
        Validating observation 1107 of 1406
        Validating observation 1108 of 1406
        Validating observation 1109 of 1406
        Validating observation 1110 of 1406
        Validating observation 1111 of 1406
        Validating observation 1112 of 1406
        Validating observation 1113 of 1406
        Validating observation 1114 of 1406
        Validating observation 1115 of 1406
        Validating observation 1116 of 1406
        Validating observation 1117 of 1406
        Validating observation 1118 of 1406
        Validating observation 1119 of 1406
        Validating observation 1120 of 1406
        Validating observation 1121 of 1406
        Validating observation 1122 of 1406
        Validating observation 1123 of 1406
        Validating observation 1124 of 1406
        Validating observation 1125 of 1406
        Validating observation 1126 of 1406
        Validating observation 1127 of 1406
        Validating observation 1128 of 1406
        Validating observation 1129 of 1406
        Validating observation 1130 of 1406
        Validating observation 1131 of 1406
        Validating observation 1132 of 1406
        Validating observation 1133 of 1406
        Validating observation 1134 of 1406
        Validating observation 1135 of 1406
        Validating observation 1136 of 1406
        Validating observation 1137 of 1406
        Validating observation 1138 of 1406
        Validating observation 1139 of 1406
        Validating observation 1140 of 1406
        Validating observation 1141 of 1406
        Validating observation 1142 of 1406
        Validating observation 1143 of 1406
        Validating observation 1144 of 1406
        Validating observation 1145 of 1406
        Validating observation 1146 of 1406
        Validating observation 1147 of 1406
        Validating observation 1148 of 1406
        Validating observation 1149 of 1406
        Validating observation 1150 of 1406
        Validating observation 1151 of 1406
        Validating observation 1152 of 1406
        Validating observation 1153 of 1406
        Validating observation 1154 of 1406
        Validating observation 1155 of 1406
        Validating observation 1156 of 1406
        Validating observation 1157 of 1406
        Validating observation 1158 of 1406
        Validating observation 1159 of 1406
        Validating observation 1160 of 1406
        Validating observation 1161 of 1406
        Validating observation 1162 of 1406
        Validating observation 1163 of 1406
        Validating observation 1164 of 1406
        Validating observation 1165 of 1406
        Validating observation 1166 of 1406
        Validating observation 1167 of 1406
        Validating observation 1168 of 1406
        Validating observation 1169 of 1406
        Validating observation 1170 of 1406
        Validating observation 1171 of 1406
        Validating observation 1172 of 1406
        Validating observation 1173 of 1406
        Validating observation 1174 of 1406
        Validating observation 1175 of 1406
        Validating observation 1176 of 1406
        Validating observation 1177 of 1406
        Validating observation 1178 of 1406
        Validating observation 1179 of 1406
        Validating observation 1180 of 1406
        Validating observation 1181 of 1406
        Validating observation 1182 of 1406
        Validating observation 1183 of 1406
        Validating observation 1184 of 1406
        Validating observation 1185 of 1406
        Validating observation 1186 of 1406
        Validating observation 1187 of 1406
        Validating observation 1188 of 1406
        Validating observation 1189 of 1406
        Validating observation 1190 of 1406
        Validating observation 1191 of 1406
        Validating observation 1192 of 1406
        Validating observation 1193 of 1406
        Validating observation 1194 of 1406
        Validating observation 1195 of 1406
        Validating observation 1196 of 1406
        Validating observation 1197 of 1406
        Validating observation 1198 of 1406
        Validating observation 1199 of 1406
        Validating observation 1200 of 1406
        Validating observation 1201 of 1406
        Validating observation 1202 of 1406
        Validating observation 1203 of 1406
        Validating observation 1204 of 1406
        Validating observation 1205 of 1406
        Validating observation 1206 of 1406
        Validating observation 1207 of 1406
        Validating observation 1208 of 1406
        Validating observation 1209 of 1406
        Validating observation 1210 of 1406
        Validating observation 1211 of 1406
        Validating observation 1212 of 1406
        Validating observation 1213 of 1406
        Validating observation 1214 of 1406
        Validating observation 1215 of 1406
        Validating observation 1216 of 1406
        Validating observation 1217 of 1406
        Validating observation 1218 of 1406
        Validating observation 1219 of 1406
        Validating observation 1220 of 1406
        Validating observation 1221 of 1406
        Validating observation 1222 of 1406
        Validating observation 1223 of 1406
        Validating observation 1224 of 1406
        Validating observation 1225 of 1406
        Validating observation 1226 of 1406
        Validating observation 1227 of 1406
        Validating observation 1228 of 1406
        Validating observation 1229 of 1406
        Validating observation 1230 of 1406
        Validating observation 1231 of 1406
        Validating observation 1232 of 1406
        Validating observation 1233 of 1406
        Validating observation 1234 of 1406
        Validating observation 1235 of 1406
        Validating observation 1236 of 1406
        Validating observation 1237 of 1406
        Validating observation 1238 of 1406
        Validating observation 1239 of 1406
        Validating observation 1240 of 1406
        Validating observation 1241 of 1406
        Validating observation 1242 of 1406
        Validating observation 1243 of 1406
        Validating observation 1244 of 1406
        Validating observation 1245 of 1406
        Validating observation 1246 of 1406
        Validating observation 1247 of 1406
        Validating observation 1248 of 1406
        Validating observation 1249 of 1406
        Validating observation 1250 of 1406
        Validating observation 1251 of 1406
        Validating observation 1252 of 1406
        Validating observation 1253 of 1406
        Validating observation 1254 of 1406
        Validating observation 1255 of 1406
        Validating observation 1256 of 1406
        Validating observation 1257 of 1406
        Validating observation 1258 of 1406
        Validating observation 1259 of 1406
        Validating observation 1260 of 1406
        Validating observation 1261 of 1406
        Validating observation 1262 of 1406
        Validating observation 1263 of 1406
        Validating observation 1264 of 1406
        Validating observation 1265 of 1406
        Validating observation 1266 of 1406
        Validating observation 1267 of 1406
        Validating observation 1268 of 1406
        Validating observation 1269 of 1406
        Validating observation 1270 of 1406
        Validating observation 1271 of 1406
        Validating observation 1272 of 1406
        Validating observation 1273 of 1406
        Validating observation 1274 of 1406
        Validating observation 1275 of 1406
        Validating observation 1276 of 1406
        Validating observation 1277 of 1406
        Validating observation 1278 of 1406
        Validating observation 1279 of 1406
        Validating observation 1280 of 1406
        Validating observation 1281 of 1406
        Validating observation 1282 of 1406
        Validating observation 1283 of 1406
        Validating observation 1284 of 1406
        Validating observation 1285 of 1406
        Validating observation 1286 of 1406
        Validating observation 1287 of 1406
        Validating observation 1288 of 1406
        Validating observation 1289 of 1406
        Validating observation 1290 of 1406
        Validating observation 1291 of 1406
        Validating observation 1292 of 1406
        Validating observation 1293 of 1406
        Validating observation 1294 of 1406
        Validating observation 1295 of 1406
        Validating observation 1296 of 1406
        Validating observation 1297 of 1406
        Validating observation 1298 of 1406
        Validating observation 1299 of 1406
        Validating observation 1300 of 1406
        Validating observation 1301 of 1406
        Validating observation 1302 of 1406
        Validating observation 1303 of 1406
        Validating observation 1304 of 1406
        Validating observation 1305 of 1406
        Validating observation 1306 of 1406
        Validating observation 1307 of 1406
        Validating observation 1308 of 1406
        Validating observation 1309 of 1406
        Validating observation 1310 of 1406
        Validating observation 1311 of 1406
        Validating observation 1312 of 1406
        Validating observation 1313 of 1406
        Validating observation 1314 of 1406
        Validating observation 1315 of 1406
        Validating observation 1316 of 1406
        Validating observation 1317 of 1406
        Validating observation 1318 of 1406
        Validating observation 1319 of 1406
        Validating observation 1320 of 1406
        Validating observation 1321 of 1406
        Validating observation 1322 of 1406
        Validating observation 1323 of 1406
        Validating observation 1324 of 1406
        Validating observation 1325 of 1406
        Validating observation 1326 of 1406
        Validating observation 1327 of 1406
        Validating observation 1328 of 1406
        Validating observation 1329 of 1406
        Validating observation 1330 of 1406
        Validating observation 1331 of 1406
        Validating observation 1332 of 1406
        Validating observation 1333 of 1406
        Validating observation 1334 of 1406
        Validating observation 1335 of 1406
        Validating observation 1336 of 1406
        Validating observation 1337 of 1406
        Validating observation 1338 of 1406
        Validating observation 1339 of 1406
        Validating observation 1340 of 1406
        Validating observation 1341 of 1406
        Validating observation 1342 of 1406
        Validating observation 1343 of 1406
        Validating observation 1344 of 1406
        Validating observation 1345 of 1406
        Validating observation 1346 of 1406
        Validating observation 1347 of 1406
        Validating observation 1348 of 1406
        Validating observation 1349 of 1406
        Validating observation 1350 of 1406
        Validating observation 1351 of 1406
        Validating observation 1352 of 1406
        Validating observation 1353 of 1406
        Validating observation 1354 of 1406
        Validating observation 1355 of 1406
        Validating observation 1356 of 1406
        Validating observation 1357 of 1406
        Validating observation 1358 of 1406
        Validating observation 1359 of 1406
        Validating observation 1360 of 1406
        Validating observation 1361 of 1406
        Validating observation 1362 of 1406
        Validating observation 1363 of 1406
        Validating observation 1364 of 1406
        Validating observation 1365 of 1406
        Validating observation 1366 of 1406
        Validating observation 1367 of 1406
        Validating observation 1368 of 1406
        Validating observation 1369 of 1406
        Validating observation 1370 of 1406
        Validating observation 1371 of 1406
        Validating observation 1372 of 1406
        Validating observation 1373 of 1406
        Validating observation 1374 of 1406
        Validating observation 1375 of 1406
        Validating observation 1376 of 1406
        Validating observation 1377 of 1406
        Validating observation 1378 of 1406
        Validating observation 1379 of 1406
        Validating observation 1380 of 1406
        Validating observation 1381 of 1406
        Validating observation 1382 of 1406
        Validating observation 1383 of 1406
        Validating observation 1384 of 1406
        Validating observation 1385 of 1406
        Validating observation 1386 of 1406
        Validating observation 1387 of 1406
        Validating observation 1388 of 1406
        Validating observation 1389 of 1406
        Validating observation 1390 of 1406
        Validating observation 1391 of 1406
        Validating observation 1392 of 1406
        Validating observation 1393 of 1406
        Validating observation 1394 of 1406
        Validating observation 1395 of 1406
        Validating observation 1396 of 1406
        Validating observation 1397 of 1406
        Validating observation 1398 of 1406
        Validating observation 1399 of 1406
        Validating observation 1400 of 1406
        Validating observation 1401 of 1406
        Validating observation 1402 of 1406
        Validating observation 1403 of 1406
        Validating observation 1404 of 1406
        Validating observation 1405 of 1406
        Validating observation 1406 of 1406
    2016-06-29 22:18:57,017 INFO - Validating Integrity Constraint 13: Required Attributes
    ## 2016-06-29 22:18:57,019 INFO - Validating Integrity Constraint 14: All Measures Present
    ## 2016-06-29 22:18:57,030 INFO - Validating Integrity Constraint 15: Measure Dimension Consistent & Integrity Constraint 16: Single Measure On Measure Dimension Observation
    ## 2016-06-29 22:18:57,031 INFO - Validating Integrity Constraint 17: All Measures Present In Measures Dimension Cube
    ## 2016-06-29 22:18:57,033 INFO - Validating Integrity Constraint 18: Consistent Dataset Links
    ## 2016-06-29 22:18:57,034 INFO - Validating Integrity Constraint 19: Codes From Code List
    ## 2016-06-29 22:18:57,108 INFO - Validating Integrity Constraint 20: Codes From Hierarchy & Integrity Constraint 21: Codes From Hierarchy (Inverse)
    ## 2016-06-29 22:18:57,112 INFO - The validation task completed in 926ms

Integrity contstraints check on DC-DEMO-sample.ttl
--------------------------------------------------

``` bash
cd ../extdata/sample-rdf
java -jar /opt/NoSPA-RDF-Data-Cube-Validator-jar/nospa-rdf-data-cube-validator-0.9.9-jar-with-dependencies.jar DC-DEMO-sample.ttl nospa
```

    ## ===NoSPA RDF Data Cube Validator===
    ## 2016-06-29 22:18:57,490 INFO - Loading cube file ...
    ## 2016-06-29 22:18:57,872 INFO - Normalizing cube at phase 1 ...
    ## 2016-06-29 22:18:57,880 INFO - Normalizing cube at phase 2 ...
    ## 2016-06-29 22:18:57,884 INFO - Validating all constraints ...
    ## 2016-06-29 22:18:57,884 INFO - Validating Integrity Constraint 1: Unique DataSet
    ## 2016-06-29 22:18:57,890 INFO - Validating Integrity Constraint 2: Unique DSD
    ## 2016-06-29 22:18:57,891 INFO - Validating Integrity Constraint 3: DSD Includes Measure
    ## 2016-06-29 22:18:57,892 INFO - Validating Integrity Constraint 4: Dimensions Have Range
    ## 2016-06-29 22:18:57,892 INFO - Validating Integrity Constraint 5: Concept Dimensions Have Code Lists
    ## 2016-06-29 22:18:57,893 INFO - Validating Integrity Constraint 6: Only Attributes May Be Optional
    ## 2016-06-29 22:18:57,894 INFO - Validating Integrity Constraint 7: Slice Keys Must Be Declared
    ## 2016-06-29 22:18:57,895 INFO - Validating Integrity Constraint 8: Slice Keys Consistent With DSD
    ## 2016-06-29 22:18:57,896 INFO - Validating Integrity Constraint 9: Unique Slice Structure
    ## 2016-06-29 22:18:57,896 INFO - Validating Integrity Constraint 10: Slice Dimensions Complete
    ## 2016-06-29 22:18:57,897 INFO - Validating Integrity Constraint 11: All Dimensions Required & Integrity Constraint 12: No Duplicate Observations
    ## 2016-06-29 22:18:57,898 INFO -     Validating dataset http://www.example.org/dc/demo/ds/dataset-DEMO
    ##     Validating observation 1 of 132
        Validating observation 2 of 132
        Validating observation 3 of 132
        Validating observation 4 of 132
        Validating observation 5 of 132
        Validating observation 6 of 132
        Validating observation 7 of 132
        Validating observation 8 of 132
        Validating observation 9 of 132
        Validating observation 10 of 132
        Validating observation 11 of 132
        Validating observation 12 of 132
        Validating observation 13 of 132
        Validating observation 14 of 132
        Validating observation 15 of 132
        Validating observation 16 of 132
        Validating observation 17 of 132
        Validating observation 18 of 132
        Validating observation 19 of 132
        Validating observation 20 of 132
        Validating observation 21 of 132
        Validating observation 22 of 132
        Validating observation 23 of 132
        Validating observation 24 of 132
        Validating observation 25 of 132
        Validating observation 26 of 132
        Validating observation 27 of 132
        Validating observation 28 of 132
        Validating observation 29 of 132
        Validating observation 30 of 132
        Validating observation 31 of 132
        Validating observation 32 of 132
        Validating observation 33 of 132
        Validating observation 34 of 132
        Validating observation 35 of 132
        Validating observation 36 of 132
        Validating observation 37 of 132
        Validating observation 38 of 132
        Validating observation 39 of 132
        Validating observation 40 of 132
        Validating observation 41 of 132
        Validating observation 42 of 132
        Validating observation 43 of 132
        Validating observation 44 of 132
        Validating observation 45 of 132
        Validating observation 46 of 132
        Validating observation 47 of 132
        Validating observation 48 of 132
        Validating observation 49 of 132
        Validating observation 50 of 132
        Validating observation 51 of 132
        Validating observation 52 of 132
        Validating observation 53 of 132
        Validating observation 54 of 132
        Validating observation 55 of 132
        Validating observation 56 of 132
        Validating observation 57 of 132
        Validating observation 58 of 132
        Validating observation 59 of 132
        Validating observation 60 of 132
        Validating observation 61 of 132
        Validating observation 62 of 132
        Validating observation 63 of 132
        Validating observation 64 of 132
        Validating observation 65 of 132
        Validating observation 66 of 132
        Validating observation 67 of 132
        Validating observation 68 of 132
        Validating observation 69 of 132
        Validating observation 70 of 132
        Validating observation 71 of 132
        Validating observation 72 of 132
        Validating observation 73 of 132
        Validating observation 74 of 132
        Validating observation 75 of 132
        Validating observation 76 of 132
        Validating observation 77 of 132
        Validating observation 78 of 132
        Validating observation 79 of 132
        Validating observation 80 of 132
        Validating observation 81 of 132
        Validating observation 82 of 132
        Validating observation 83 of 132
        Validating observation 84 of 132
        Validating observation 85 of 132
        Validating observation 86 of 132
        Validating observation 87 of 132
        Validating observation 88 of 132
        Validating observation 89 of 132
        Validating observation 90 of 132
        Validating observation 91 of 132
        Validating observation 92 of 132
        Validating observation 93 of 132
        Validating observation 94 of 132
        Validating observation 95 of 132
        Validating observation 96 of 132
        Validating observation 97 of 132
        Validating observation 98 of 132
        Validating observation 99 of 132
        Validating observation 100 of 132
        Validating observation 101 of 132
        Validating observation 102 of 132
        Validating observation 103 of 132
        Validating observation 104 of 132
        Validating observation 105 of 132
        Validating observation 106 of 132
        Validating observation 107 of 132
        Validating observation 108 of 132
        Validating observation 109 of 132
        Validating observation 110 of 132
        Validating observation 111 of 132
        Validating observation 112 of 132
        Validating observation 113 of 132
        Validating observation 114 of 132
        Validating observation 115 of 132
        Validating observation 116 of 132
        Validating observation 117 of 132
        Validating observation 118 of 132
        Validating observation 119 of 132
        Validating observation 120 of 132
        Validating observation 121 of 132
        Validating observation 122 of 132
        Validating observation 123 of 132
        Validating observation 124 of 132
        Validating observation 125 of 132
        Validating observation 126 of 132
        Validating observation 127 of 132
        Validating observation 128 of 132
        Validating observation 129 of 132
        Validating observation 130 of 132
        Validating observation 131 of 132
        Validating observation 132 of 132
    2016-06-29 22:18:57,917 INFO - Validating Integrity Constraint 13: Required Attributes
    ## 2016-06-29 22:18:57,918 INFO - Validating Integrity Constraint 14: All Measures Present
    ## 2016-06-29 22:18:57,921 INFO - Validating Integrity Constraint 15: Measure Dimension Consistent & Integrity Constraint 16: Single Measure On Measure Dimension Observation
    ## 2016-06-29 22:18:57,922 INFO - Validating Integrity Constraint 17: All Measures Present In Measures Dimension Cube
    ## 2016-06-29 22:18:57,924 INFO - Validating Integrity Constraint 18: Consistent Dataset Links
    ## 2016-06-29 22:18:57,924 INFO - Validating Integrity Constraint 19: Codes From Code List
    ## 2016-06-29 22:18:57,940 INFO - Validating Integrity Constraint 20: Codes From Hierarchy & Integrity Constraint 21: Codes From Hierarchy (Inverse)
    ## 2016-06-29 22:18:57,942 INFO - The validation task completed in 458ms

Display of the validation files
-------------------------------

``` bash
cd ../extdata/sample-rdf
cat validation_result_*.md
```

    ## RDF Cube Validation Result
    ## ==========================
    ## 
    ## Validator: NoSPA
    ## Wed Jun 29 22:18:48 CEST 2016
    ## DC-DM-sample.ttl
    ## 
    ## Integrity Constraint 1: Unique DataSet
    ## --------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 2: Unique DSD
    ## ----------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 3: DSD Includes Measure
    ## --------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 4: Dimensions Have Range
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 5: Concept Dimensions Have Code Lists
    ## ----------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 6: Only Attributes May Be Optional
    ## -------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 7: Slice Keys Must Be Declared
    ## ---------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 8: Slice Keys Consistent With DSD
    ## ------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 9: Unique Slice Structure
    ## ----------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 10: Slice Dimensions Complete
    ## --------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 11: All Dimensions Required
    ## ------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 12: No Duplicate Observations
    ## --------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 13: Required Attributes
    ## --------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 14: All Measures Present
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 15: Measure Dimension Consistent
    ## -----------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 16: Single Measure On Measure Dimension Observation
    ## ------------------------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 17: All Measures Present In Measures Dimension Cube
    ## ------------------------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 18: Consistent Dataset Links
    ## -------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 19: Codes From Code List
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 20: Codes From Hierarchy
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 21: Codes From Hierarchy (Inverse)
    ## -------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## RDF Cube Validation Result
    ## ==========================
    ## 
    ## Validator: NoSPA
    ## Wed Jun 29 22:18:49 CEST 2016
    ## DC-AE-sample.ttl
    ## 
    ## Integrity Constraint 1: Unique DataSet
    ## --------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 2: Unique DSD
    ## ----------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 3: DSD Includes Measure
    ## --------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 4: Dimensions Have Range
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 5: Concept Dimensions Have Code Lists
    ## ----------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 6: Only Attributes May Be Optional
    ## -------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 7: Slice Keys Must Be Declared
    ## ---------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 8: Slice Keys Consistent With DSD
    ## ------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 9: Unique Slice Structure
    ## ----------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 10: Slice Dimensions Complete
    ## --------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 11: All Dimensions Required
    ## ------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 12: No Duplicate Observations
    ## --------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 13: Required Attributes
    ## --------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 14: All Measures Present
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 15: Measure Dimension Consistent
    ## -----------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 16: Single Measure On Measure Dimension Observation
    ## ------------------------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 17: All Measures Present In Measures Dimension Cube
    ## ------------------------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 18: Consistent Dataset Links
    ## -------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 19: Codes From Code List
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 20: Codes From Hierarchy
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 21: Codes From Hierarchy (Inverse)
    ## -------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## RDF Cube Validation Result
    ## ==========================
    ## 
    ## Validator: NoSPA
    ## Wed Jun 29 22:18:50 CEST 2016
    ## DC-DEMO-sample.ttl
    ## 
    ## Integrity Constraint 1: Unique DataSet
    ## --------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 2: Unique DSD
    ## ----------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 3: DSD Includes Measure
    ## --------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 4: Dimensions Have Range
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 5: Concept Dimensions Have Code Lists
    ## ----------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 6: Only Attributes May Be Optional
    ## -------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 7: Slice Keys Must Be Declared
    ## ---------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 8: Slice Keys Consistent With DSD
    ## ------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 9: Unique Slice Structure
    ## ----------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 10: Slice Dimensions Complete
    ## --------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 11: All Dimensions Required
    ## ------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 12: No Duplicate Observations
    ## --------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 13: Required Attributes
    ## --------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 14: All Measures Present
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 15: Measure Dimension Consistent
    ## -----------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 16: Single Measure On Measure Dimension Observation
    ## ------------------------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 17: All Measures Present In Measures Dimension Cube
    ## ------------------------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 18: Consistent Dataset Links
    ## -------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 19: Codes From Code List
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 20: Codes From Hierarchy
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 21: Codes From Hierarchy (Inverse)
    ## -------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## RDF Cube Validation Result
    ## ==========================
    ## 
    ## Validator: NoSPA
    ## Wed Jun 29 22:18:51 CEST 2016
    ## DC-DM-sample.ttl
    ## 
    ## Integrity Constraint 1: Unique DataSet
    ## --------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 2: Unique DSD
    ## ----------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 3: DSD Includes Measure
    ## --------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 4: Dimensions Have Range
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 5: Concept Dimensions Have Code Lists
    ## ----------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 6: Only Attributes May Be Optional
    ## -------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 7: Slice Keys Must Be Declared
    ## ---------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 8: Slice Keys Consistent With DSD
    ## ------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 9: Unique Slice Structure
    ## ----------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 10: Slice Dimensions Complete
    ## --------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 11: All Dimensions Required
    ## ------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 12: No Duplicate Observations
    ## --------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 13: Required Attributes
    ## --------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 14: All Measures Present
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 15: Measure Dimension Consistent
    ## -----------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 16: Single Measure On Measure Dimension Observation
    ## ------------------------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 17: All Measures Present In Measures Dimension Cube
    ## ------------------------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 18: Consistent Dataset Links
    ## -------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 19: Codes From Code List
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 20: Codes From Hierarchy
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 21: Codes From Hierarchy (Inverse)
    ## -------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## RDF Cube Validation Result
    ## ==========================
    ## 
    ## Validator: NoSPA
    ## Wed Jun 29 22:18:52 CEST 2016
    ## DC-AE-sample.ttl
    ## 
    ## Integrity Constraint 1: Unique DataSet
    ## --------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 2: Unique DSD
    ## ----------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 3: DSD Includes Measure
    ## --------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 4: Dimensions Have Range
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 5: Concept Dimensions Have Code Lists
    ## ----------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 6: Only Attributes May Be Optional
    ## -------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 7: Slice Keys Must Be Declared
    ## ---------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 8: Slice Keys Consistent With DSD
    ## ------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 9: Unique Slice Structure
    ## ----------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 10: Slice Dimensions Complete
    ## --------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 11: All Dimensions Required
    ## ------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 12: No Duplicate Observations
    ## --------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 13: Required Attributes
    ## --------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 14: All Measures Present
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 15: Measure Dimension Consistent
    ## -----------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 16: Single Measure On Measure Dimension Observation
    ## ------------------------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 17: All Measures Present In Measures Dimension Cube
    ## ------------------------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 18: Consistent Dataset Links
    ## -------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 19: Codes From Code List
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 20: Codes From Hierarchy
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 21: Codes From Hierarchy (Inverse)
    ## -------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## RDF Cube Validation Result
    ## ==========================
    ## 
    ## Validator: NoSPA
    ## Wed Jun 29 22:18:53 CEST 2016
    ## DC-DEMO-sample.ttl
    ## 
    ## Integrity Constraint 1: Unique DataSet
    ## --------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 2: Unique DSD
    ## ----------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 3: DSD Includes Measure
    ## --------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 4: Dimensions Have Range
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 5: Concept Dimensions Have Code Lists
    ## ----------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 6: Only Attributes May Be Optional
    ## -------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 7: Slice Keys Must Be Declared
    ## ---------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 8: Slice Keys Consistent With DSD
    ## ------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 9: Unique Slice Structure
    ## ----------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 10: Slice Dimensions Complete
    ## --------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 11: All Dimensions Required
    ## ------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 12: No Duplicate Observations
    ## --------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 13: Required Attributes
    ## --------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 14: All Measures Present
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 15: Measure Dimension Consistent
    ## -----------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 16: Single Measure On Measure Dimension Observation
    ## ------------------------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 17: All Measures Present In Measures Dimension Cube
    ## ------------------------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 18: Consistent Dataset Links
    ## -------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 19: Codes From Code List
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 20: Codes From Hierarchy
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 21: Codes From Hierarchy (Inverse)
    ## -------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## RDF Cube Validation Result
    ## ==========================
    ## 
    ## Validator: NoSPA
    ## Wed Jun 29 22:18:55 CEST 2016
    ## DC-DM-sample.ttl
    ## 
    ## Integrity Constraint 1: Unique DataSet
    ## --------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 2: Unique DSD
    ## ----------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 3: DSD Includes Measure
    ## --------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 4: Dimensions Have Range
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 5: Concept Dimensions Have Code Lists
    ## ----------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 6: Only Attributes May Be Optional
    ## -------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 7: Slice Keys Must Be Declared
    ## ---------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 8: Slice Keys Consistent With DSD
    ## ------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 9: Unique Slice Structure
    ## ----------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 10: Slice Dimensions Complete
    ## --------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 11: All Dimensions Required
    ## ------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 12: No Duplicate Observations
    ## --------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 13: Required Attributes
    ## --------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 14: All Measures Present
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 15: Measure Dimension Consistent
    ## -----------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 16: Single Measure On Measure Dimension Observation
    ## ------------------------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 17: All Measures Present In Measures Dimension Cube
    ## ------------------------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 18: Consistent Dataset Links
    ## -------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 19: Codes From Code List
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 20: Codes From Hierarchy
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 21: Codes From Hierarchy (Inverse)
    ## -------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## RDF Cube Validation Result
    ## ==========================
    ## 
    ## Validator: NoSPA
    ## Wed Jun 29 22:18:56 CEST 2016
    ## DC-AE-sample.ttl
    ## 
    ## Integrity Constraint 1: Unique DataSet
    ## --------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 2: Unique DSD
    ## ----------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 3: DSD Includes Measure
    ## --------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 4: Dimensions Have Range
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 5: Concept Dimensions Have Code Lists
    ## ----------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 6: Only Attributes May Be Optional
    ## -------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 7: Slice Keys Must Be Declared
    ## ---------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 8: Slice Keys Consistent With DSD
    ## ------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 9: Unique Slice Structure
    ## ----------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 10: Slice Dimensions Complete
    ## --------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 11: All Dimensions Required
    ## ------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 12: No Duplicate Observations
    ## --------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 13: Required Attributes
    ## --------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 14: All Measures Present
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 15: Measure Dimension Consistent
    ## -----------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 16: Single Measure On Measure Dimension Observation
    ## ------------------------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 17: All Measures Present In Measures Dimension Cube
    ## ------------------------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 18: Consistent Dataset Links
    ## -------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 19: Codes From Code List
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 20: Codes From Hierarchy
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 21: Codes From Hierarchy (Inverse)
    ## -------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## RDF Cube Validation Result
    ## ==========================
    ## 
    ## Validator: NoSPA
    ## Wed Jun 29 22:18:57 CEST 2016
    ## DC-DEMO-sample.ttl
    ## 
    ## Integrity Constraint 1: Unique DataSet
    ## --------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 2: Unique DSD
    ## ----------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 3: DSD Includes Measure
    ## --------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 4: Dimensions Have Range
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 5: Concept Dimensions Have Code Lists
    ## ----------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 6: Only Attributes May Be Optional
    ## -------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 7: Slice Keys Must Be Declared
    ## ---------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 8: Slice Keys Consistent With DSD
    ## ------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 9: Unique Slice Structure
    ## ----------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 10: Slice Dimensions Complete
    ## --------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 11: All Dimensions Required
    ## ------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 12: No Duplicate Observations
    ## --------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 13: Required Attributes
    ## --------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 14: All Measures Present
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 15: Measure Dimension Consistent
    ## -----------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 16: Single Measure On Measure Dimension Observation
    ## ------------------------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 17: All Measures Present In Measures Dimension Cube
    ## ------------------------------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 18: Consistent Dataset Links
    ## -------------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 19: Codes From Code List
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 20: Codes From Hierarchy
    ## ---------------------------------------------
    ## 
    ## Pass.
    ## 
    ## Integrity Constraint 21: Codes From Hierarchy (Inverse)
    ## -------------------------------------------------------
    ## 
    ## Pass.

(This is not a very nice way to do it).
