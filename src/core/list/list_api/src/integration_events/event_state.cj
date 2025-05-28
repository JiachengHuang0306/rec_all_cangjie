package list_api.integration_events

public enum EventState <: Equatable<EventState> {
    | NotPublished | InProcess | Published | PublishFailed

    public func toInt64(): Int64 {
        return match (this) {
            case NotPublished => 0
            case InProcess => 1
            case Published => 2
            case PublishFailed => 3
        }
    }

    public static func fromInt64(int64: Int64): EventState {
        return match (int64) {
            case 0 => NotPublished
            case 1 => InProcess
            case 2 => Published
            case 3 => PublishFailed
            case _ => throw Exception("Unknown EventState")
        }
    }

    public operator func ==(that: EventState): Bool {
        return this.toInt64() == that.toInt64()
    }

    public operator func !=(that: EventState): Bool {
        return this.toInt64() != that.toInt64()
    }
}