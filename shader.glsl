void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = (fragCoord - 0.5 * iResolution.xy) / iResolution.y;
    float time = iTime * 0.5;
    vec3 col = vec3(0.0);
    for(float i = 0.0; i < 3.0; i++) {
        vec2 p = uv * (2.0 + i * 0.5);
        float angle = time * (0.3 + i * 0.1);
        float c = cos(angle);
        float s = sin(angle);
        p = mat2(c, -s, s, c) * p;
        float wave = sin(p.x * 3.0 + time * 2.0) * 0.5;
        wave += sin(p.y * 2.5 - time * 1.5) * 0.5;
        wave += sin((p.x + p.y) * 2.0 + time) * 0.3;
        float dist = length(uv);
        wave *= (1.0 - dist * 0.5);
        if(i == 0.0) {
            col += vec3(0.8, 0.2, 0.9) * wave * 0.5;
        } else if(i == 1.0) {
            col += vec3(0.2, 0.6, 1.0) * wave * 0.4;
        } else {
            col += vec3(1.0, 0.5, 0.2) * wave * 0.3;
        }
    }
    float pulse = sin(time * 3.0) * 0.5 + 0.5;
    float circles = 0.0;
    
    for(float i = 1.0; i < 4.0; i++) {
        float radius = i * 0.3 + pulse * 0.2;
        float ring = abs(length(uv) - radius);
        ring = smoothstep(0.05, 0.0, ring);
        circles += ring * (1.0 - i * 0.2);
    }
    vec3 circleCol = vec3(0.3, 0.8, 1.0) * circles * 0.6;
    col += circleCol;
    vec2 sparkleUV = uv * 5.0;
    sparkleUV.x += sin(time * 2.0 + sparkleUV.y * 3.0) * 0.3;
    sparkleUV.y += cos(time * 1.5 + sparkleUV.x * 2.0) * 0.3;
    
    float sparkle = 0.0;
    sparkle += sin(sparkleUV.x * 10.0 + time * 3.0) * 0.5 + 0.5;
    sparkle *= sin(sparkleUV.y * 10.0 - time * 2.5) * 0.5 + 0.5;
    sparkle = pow(sparkle, 5.0);
    
    col += vec3(1.0, 1.0, 0.8) * sparkle * 0.3;
    float gradient = 1.0 - length(uv) * 0.7;
    col *= gradient;
    vec3 bg = vec3(0.05, 0.02, 0.1);
    col += bg;
    col = pow(col, vec3(0.8));
    col *= 1.2;
    fragColor = vec4(col, 1.0);
}
