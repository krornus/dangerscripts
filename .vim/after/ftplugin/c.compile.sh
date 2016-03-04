executable=$(python -c "print('$1'.replace('.c',''))")

gcc $1 -o $executable
chmod +x $executable
./$executable

