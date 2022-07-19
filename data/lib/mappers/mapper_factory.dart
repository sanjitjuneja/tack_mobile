part of mappers;

class MapperFactory {
  GroupMapper get groupMapper => GroupMapper();

  TackStatusMapper get tackStatusMapper => TackStatusMapper();

  TackMapper get tackMapper => TackMapper(tackStatusMapper: tackStatusMapper);
}
