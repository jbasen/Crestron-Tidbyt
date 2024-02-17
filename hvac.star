load("render.star", "render")
load("http.star", "http")

URL = "http://[Crestron Processor IP Address]:[Port for Communications]/"

def main():
    rep = http.get(URL)
    if rep.status_code != 200:
        fail("Request failed with status %d", rep.status_code)

    temperature = rep.json()["Temperature"]
    setpoint = rep.json()["Setpoint"]
    mode = rep.json()["Mode"]

    if mode == "OFF":
        return render.Root( child = render.WrappedText(content = "Temp:%d° Mode:%s" % (temperature, mode )))
    else:		
        return render.Root( child = render.WrappedText(content = "Temp:%d° Setpoint:%d° Mode:%s" % (temperature, setpoint, mode )))
