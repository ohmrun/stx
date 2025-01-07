package stx.nano;

/**
 * Church Encoding(ish)
 */
enum Church<C = Church>{
  Zero;
  AddOne(c:C);
}