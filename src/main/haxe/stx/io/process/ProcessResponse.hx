package stx.io.process;

enum ProcessResponse{
  PResState(state:ProcessState);
  PResValue(res:Outcome<InputResponse,InputResponse>);
  PResError(raw:Refuse<ProcessFailure>);
  PResOffer(req:ProcessRequest);
}