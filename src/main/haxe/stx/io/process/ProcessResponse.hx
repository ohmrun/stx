package stx.io.process;

enum ProcessResponse{
  PResBlank;
  PResState(state:ProcessState);
  PResValue(res:Outcome<InputResponse,InputResponse>);
  PResError(raw:Error<stx.fail.ProcessFailure>);
  PResOffer(req:ProcessRequest);
}