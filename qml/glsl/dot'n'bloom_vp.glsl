/*
    CRT shader

    Copyright (C) 2010-2012 cgwg, Themaister and DOLLS
    Adapted by cmakeshift

    This program is free software; you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by the Free
    Software Foundation; either version 2 of the License, or (at your option)
    any later version.
*/

uniform highp mat4 qt_Matrix;
attribute highp vec4 qt_Vertex;
attribute highp vec2 qt_MultiTexCoord0;

      varying vec2 c00;
      varying vec2 c10;
      varying vec2 c20;
      varying vec2 c01;
      varying vec2 c11;
      varying vec2 c21;
      varying vec2 c02;
      varying vec2 c12;
      varying vec2 c22;
      varying vec2 pixel_no;
      uniform vec2 rubyTextureSize;
      uniform vec2 rubyOutputSize;
      uniform vec2 rubyInputSize;

      void main()
      {
         gl_Position = qt_Matrix * qt_Vertex;
         float dx = 1.0 / rubyTextureSize.x;
         float dy = 1.0 / rubyTextureSize.y;

         vec2 tex = qt_MultiTexCoord0;
         c00 = tex + vec2(-dx, -dy);
         c10 = tex + vec2(  0, -dy);
         c20 = tex + vec2( dx, -dy);
         c01 = tex + vec2(-dx,   0);
         c11 = tex + vec2(  0,   0);
         c21 = tex + vec2( dx,   0);
         c02 = tex + vec2(-dx,  dy);
         c12 = tex + vec2(  0,  dy);
         c22 = tex + vec2( dx,  dy);
         pixel_no = tex * rubyTextureSize;
      }