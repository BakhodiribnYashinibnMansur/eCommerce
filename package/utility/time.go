package utility

import "time"

func GetCurrentTime() time.Time {
	var timeNow, _ = time.Parse("2006-Jan-02 Monday 03:04:05", "2020-Jan-29 Wednesday 12:19:25")
	return timeNow
}
