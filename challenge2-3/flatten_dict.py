
def flatten_dict(input, lkey=''):
    out = {}
    for rkey,val in input.items():
        key = lkey+rkey
        if isinstance(val, dict):
            out.update(flatten_dict(val, key+'_'))
        else:
            out[key] = val
    return out
input_object = {"x": {"y": {"z": "a"}}}
  
# printing Input  
print ("Input = ", str(input_object)) 
  
  
# Printing Output  
print ("Output = ", flatten_dict(input_object))
